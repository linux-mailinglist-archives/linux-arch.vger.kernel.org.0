Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30E3769CED
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 18:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjGaQju (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 12:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjGaQjh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 12:39:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389DB173F;
        Mon, 31 Jul 2023 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OQo3yL4yG3jGyWSkou4YxRtg8JFH3orkKLuMQw2GA/o=; b=XyE5qzlvho47FbWNmCDHfzzD23
        TD+vjVmfbujk2rxhGTl5FeDSkSpPR9xhwnfuuZdcnUFgyYgtfMfL8Al1n9Fs8ZPzeAWt3D8kBaxE0
        xkOfXwDby6DwjZf/PGj9OI6d+5QAYtAc9CUDeskJddccqpbaugMVsITh+RDrj4yFgIaXe0nhgkzor
        56z7YN7zXuw7ujKhH5HWUpv4mlzr8m+/4YDbAf5tObdgrmEiH53Aqqd+thv9lUOeA2roFSQnSAifu
        rrbtH8W26v5XKbnsk4ckgo4GESKjWz1TIK7u3drS6B6yZsxzqHGUb9zAfdq6mEx16Semp7xzb/NJ8
        QX/m3Vxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQVv0-002ffe-NZ; Mon, 31 Jul 2023 16:38:50 +0000
Date:   Mon, 31 Jul 2023 17:38:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "xuyu@linux.alibaba.com" <xuyu@linux.alibaba.com>
Subject: Re: [PATCH RFC v2 0/4] Add support for sharing page tables across
 processes (Previously mshare)
Message-ID: <ZMfjmhaqVZyZNNMW@casper.infradead.org>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
 <74fe50d9-9be9-cc97-e550-3ca30aebfd13@linux.alibaba.com>
 <ZMeoHoM8j/ric0Bh@casper.infradead.org>
 <ae3bbfba-4207-ec5b-b4dd-ea63cb52883d@redhat.com>
 <9faea1cf-d3da-47ff-eb41-adc5bd73e5ca@linux.alibaba.com>
 <d3d03475-7977-fc55-188d-7df350ee0f29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d03475-7977-fc55-188d-7df350ee0f29@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 31, 2023 at 06:30:22PM +0200, David Hildenbrand wrote:
> Assume we do do the page table sharing at mmap time, if the flags are right.
> Let's focus on the most common:
> 
> mmap(memfd, PROT_READ | PROT_WRITE, MAP_SHARED)
> 
> And doing the same in each and every process.

That may be the most common in your usage, but for a database, you're
looking at two usage scenarios.  Postgres calls mmap() on the database
file itself so that all processes share the kernel page cache.
Some Commercial Databases call mmap() on a hugetlbfs file so that all
processes share the same userspace buffer cache.  Other Commecial
Databases call shmget() / shmat() with SHM_HUGETLB for the exact
same reason.

This is why I proposed mshare().  Anyone can use it for anything.
We have such a diverse set of users who want to do stuff with shared
page tables that we should not be tying it to memfd or any other
filesystem.  Not to mention that it's more flexible; you can map
individual 4kB files into it and still get page table sharing.

