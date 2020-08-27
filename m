Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC54254A9B
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgH0QV6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgH0QVa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 12:21:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0992FC061234;
        Thu, 27 Aug 2020 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=R6WPMXHxuThDwBA5rNw60E2TTV+VwJYDfZXEOOsKtQI=; b=ayMbycB7vBUyHzQP5acpxK6STC
        skWrZnEwpUFX1sVjA4L4PjiHUPRCCloxVl8W28NkjOyqN4fNkY0hy92/gYQLk4q7ItnvvOayCS6JF
        Tk5c8Oh4pm9Ar1JX41LOGiJXOMrxUCXXrgw0c8umzjpqqL0gLeXDeeEWWjs7gnTED0z5f+kBsl+/v
        /FdWp+IX37WBaw4UsDm3mfTCRuwAuV6TgoLJpB1dEbs5lZbYCp45EqmyQo4N+Xbwy2kaEuBiMt167
        6hjPBjBlt1XAgbYFaCr5tfXfA6N0dMHxYU3Q1z7xXAdfPuqYSjpLEjRm92R15v/FlBLi5sw0SQSGx
        OJkIMbYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBKe5-0001WR-A6; Thu, 27 Aug 2020 16:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B2197306099;
        Thu, 27 Aug 2020 18:20:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6E74B2C2868F1; Thu, 27 Aug 2020 18:20:57 +0200 (CEST)
Message-ID: <20200827161237.889877377@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Aug 2020 18:12:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 0/7] kprobes: Make kretprobes lockless
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

These are on top of Masami's generic kretprobe handler patches (v1):

  https://lkml.kernel.org/r/159844957216.510284.17683703701627367133.stgit@devnote2

They are very lightly tested, esp. the freelist stuff has basically only been
translated to kernel C without much thinking (while attending LPC), all bugs
are undoubted mine and not Cameron's.

Changelogs are terse or nonexistant :/


