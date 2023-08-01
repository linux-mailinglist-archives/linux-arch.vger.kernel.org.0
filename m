Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2776976AB4D
	for <lists+linux-arch@lfdr.de>; Tue,  1 Aug 2023 10:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjHAItn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Aug 2023 04:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHAItn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Aug 2023 04:49:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCD810FA;
        Tue,  1 Aug 2023 01:49:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690879770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7y14opVxFYlYAWiVX/5Sl0k5U4rJuCot7ooRCfUHosM=;
        b=xSBCKEGpQRWVDFGStCmuLyE+mQlyRwhxJqV9v2T37MKHoMSEykElcc5PSp2bfCc80zh6I3
        CJYu86vWVLBtgt0SEg+cXQbxUMf+lAPAOPB8tRL/WxZ/rnKTuOqMSUxoG5T8HiqRUWwUsq
        XOdQP1IK8qsMmQdDK2sEzQFyNk8Orh3RRFCsLBCzR5LP1Wo2DutikbelmNpJSuMj+FEnzY
        bVLnlLkUtFsrK2FRar7mUMj8wT1yjmwKa5sC3MI5NY2ksJIgmGRS2OMo5fHzbMbfxxeJD+
        acAGZlsc0ZIxwUUamEGP9fpIBddOf0zTm348SFs71JZk5V8e/iQDs/N98s0g1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690879770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7y14opVxFYlYAWiVX/5Sl0k5U4rJuCot7ooRCfUHosM=;
        b=4fCPbVP95QTc1VJ4591RDCaOfcGUPX3GsmIqewJDoQZxV4/B+CQJ5uH/TC5jqQA8Upb2az
        0q6o3slkGaltNvAg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
In-Reply-To: <20230731225959.GE51835@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org> <87edkonjrk.ffs@tglx>
 <87mszcm0zw.ffs@tglx>
 <20230731192012.GA11704@hirez.programming.kicks-ass.net>
 <87a5vbn5r0.ffs@tglx>
 <20230731213341.GB51835@hirez.programming.kicks-ass.net>
 <87y1ivln1v.ffs@tglx>
 <20230731225959.GE51835@hirez.programming.kicks-ass.net>
Date:   Tue, 01 Aug 2023 10:49:29 +0200
Message-ID: <87edknkuzq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 01 2023 at 00:59, Peter Zijlstra wrote:
> On Tue, Aug 01, 2023 at 12:43:24AM +0200, Thomas Gleixner wrote:
> Which then gets people to write garbage like:
>
> 	futex_wake(add, 0xFFFF, 1, (union futex_flags){ .flags = FUTEX2_SIZE_U16 | FUTEX2_PRIVATE));
> or
> 	futex_wake(add, 0xFFFF, 1, (union futex_flags){ .size = FUTEX2_SIZE_U16, private = true, ));
>
> You really want that ?

Well, people write garbage no matter what. So just keep the flags and
make the names explicit.

Note to myself: /me shouldn't look at futex patches when tired
