Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7BA1CE015
	for <lists+linux-arch@lfdr.de>; Mon, 11 May 2020 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgEKQIf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 May 2020 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729556AbgEKQIe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 May 2020 12:08:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5742C061A0C;
        Mon, 11 May 2020 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z/d+TrVPdrsAk44CoqF5IGdRSpSm6eZWCXJ37KrAT1c=; b=u9oRacQAicljKtNFCklFNYSPYA
        WiFsRel6xtyrX4c3ZQDFQ9rMR0M0J9/x8c4PANjWEpVfgSPLO9LZrfI1TQP7FIAr2h4FF8N2dP8iH
        721hzr4Lg/7ERwJhu86zdHvsYVXiKKBfGNjKdq4jJv71t4n2136iHYokfcJ/derIadDpfLknKA9jg
        +49xmmwXv6bdIxA2FcCVmsNqFhxkKgbuQ0Og5FLSSgj/FassEHnGFHUTdMbw+EoyS/wTK5N2yVzMs
        EX+5voAQynyenRLjd4opgL1meH/rOLCCz3sFUfJ8VM+luujCJsgbEWA4HlCZ98CPPb/npmFFII5i+
        lpW97mkQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYAyc-0005N0-BE; Mon, 11 May 2020 16:08:22 +0000
Date:   Mon, 11 May 2020 09:08:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joerg Roedel <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>,
        x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Message-ID: <20200511160822.GX16070@bombadil.infradead.org>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508192000.GB2957@hirez.programming.kicks-ass.net>
 <20200508213407.GT8135@suse.de>
 <20200509092516.GC2957@hirez.programming.kicks-ass.net>
 <20200510011157.GU16070@bombadil.infradead.org>
 <20200511073134.GD2957@hirez.programming.kicks-ass.net>
 <20200511155204.GW16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20200511155204.GW16070@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2020 at 08:52:04AM -0700, Matthew Wilcox wrote:
> On Mon, May 11, 2020 at 09:31:34AM +0200, Peter Zijlstra wrote:
> > On Sat, May 09, 2020 at 06:11:57PM -0700, Matthew Wilcox wrote:
> > > Iterating an XArray (whether the entire thing
> > > or with marks) is RCU-safe and faster than iterating a linked list,
> > > so this should solve the problem?
> > 
> > It can hardly be faster if you want all elements -- which is I think the
> > case here. We only call into this if we change an entry, and then we
> > need to propagate that change to all.
> 
> Of course it can be faster.  Iterating an array is faster than iterating
> a linked list because caches.  While an XArray is a segmented array
> (so slower than a plain array), it's plainly going to be faster than
> iterating a linked list.

Quantifying this:

$ ./array-vs-list 
walked sequential array in 0.002039s
walked sequential list in 0.002807s
walked sequential array in 0.002017s
walked shuffled list in 0.102367s
walked shuffled array in 0.012114s

Attached is the source code; above results on a Kaby Lake with
CFLAGS="-O2 -W -Wall -g".

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="array-vs-list.c"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

unsigned long count = 1000 * 1000;
unsigned int verbose;

struct object {
	struct object *next;
	struct object *prev;
	unsigned int value;
};

#define printv(level, fmt, ...) \
	if (level <= verbose) { printf(fmt, ##__VA_ARGS__); }

void check_total(unsigned long total)
{
	if (total * 2 != count * (count + 1))
		printf("Check your staging! (%lu %lu)\n", total, count);
}

void alloc_objs(struct object **array)
{
	unsigned long i;

	for (i = 0; i < count; i++) {
		struct object *obj = malloc(sizeof(*obj));

		obj->value = i + 1;
		/* Add to the array */
		array[i] = obj;
	}
}

void shuffle(struct object **array, unsigned long seed)
{
	unsigned long i;

	printv(1, "random seed %lu\n", seed);
	srand48(seed);

	/* Shuffle the array */
	for (i = 1; i < count; i++) {
		struct object *obj;
		unsigned long j = (unsigned int)mrand48() % (i + 1);

		if (i == j)
			continue;
		obj = array[j];
		array[j] = array[i];
		array[i] = obj;
	}
}

void create_list(struct object **array, struct object *list)
{
	unsigned long i;

	list->next = list;
	list->prev = list;

	for (i = 0; i < count; i++) {
		struct object *obj = array[i];
		/* Add to the tail of the list */
		obj->next = list;
		obj->prev = list->prev;
		list->prev->next = obj;
		list->prev = obj;
	}
}

void walk_list(struct object *list)
{
	unsigned long total = 0;
	struct object *obj;

	for (obj = list->next; obj != list; obj = obj->next) {
		total += obj->value;
	}

	check_total(total);
}

void walk_array(struct object **array)
{
	unsigned long total = 0;
	unsigned long i;

	for (i = 0; i < count; i++) {
		total += array[i]->value;
	}

	check_total(total);
}

/* time2 - time1 */
double diff_time(struct timespec *time1, struct timespec *time2)
{
	double result = time2->tv_nsec - time1->tv_nsec;

	return time2->tv_sec - time1->tv_sec + result / 1000 / 1000 / 1000;
}

int main(int argc, char **argv)
{
	int opt;
	unsigned long seed = time(NULL);
	struct object **array;
	struct object list;
	struct timespec time1, time2;

	while ((opt = getopt(argc, argv, "c:s:v")) != -1) {
		if (opt == 'c')
			count *= strtoul(optarg, NULL, 0);
		else if (opt == 's')
			seed = strtoul(optarg, NULL, 0);
		else if (opt == 'v')
			verbose++;
	}

	clock_gettime(CLOCK_MONOTONIC, &time1);
	array = calloc(count, sizeof(void *));
	alloc_objs(array);
	clock_gettime(CLOCK_MONOTONIC, &time2);
	printv(1, "allocated %lu items in %fs\n", count,
			diff_time(&time1, &time2));

	clock_gettime(CLOCK_MONOTONIC, &time1);
	walk_array(array);
	clock_gettime(CLOCK_MONOTONIC, &time2);
	printf("walked sequential array in %fs\n",
			diff_time(&time1, &time2));

	clock_gettime(CLOCK_MONOTONIC, &time1);
	create_list(array, &list);
	clock_gettime(CLOCK_MONOTONIC, &time2);
	printv(1, "created list in %fs\n",
			diff_time(&time1, &time2));

	clock_gettime(CLOCK_MONOTONIC, &time1);
	walk_list(&list);
	clock_gettime(CLOCK_MONOTONIC, &time2);
	printf("walked sequential list in %fs\n",
			diff_time(&time1, &time2));

	clock_gettime(CLOCK_MONOTONIC, &time1);
	walk_array(array);
	clock_gettime(CLOCK_MONOTONIC, &time2);
	printf("walked sequential array in %fs\n",
			diff_time(&time1, &time2));

	clock_gettime(CLOCK_MONOTONIC, &time1);
	shuffle(array, seed);
	clock_gettime(CLOCK_MONOTONIC, &time2);
	printv(1, "shuffled array in %fs\n",
			diff_time(&time1, &time2));

	clock_gettime(CLOCK_MONOTONIC, &time1);
	create_list(array, &list);
	clock_gettime(CLOCK_MONOTONIC, &time2);
	printv(1, "created list in %fs\n",
			diff_time(&time1, &time2));

	clock_gettime(CLOCK_MONOTONIC, &time1);
	walk_list(&list);
	clock_gettime(CLOCK_MONOTONIC, &time2);
	printf("walked shuffled list in %fs\n",
			diff_time(&time1, &time2));

	clock_gettime(CLOCK_MONOTONIC, &time1);
	walk_array(array);
	clock_gettime(CLOCK_MONOTONIC, &time2);
	printf("walked shuffled array in %fs\n",
			diff_time(&time1, &time2));

	return 0;
}

--wac7ysb48OaltWcw--
