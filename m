Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EDE711F3A
	for <lists+linux-arch@lfdr.de>; Fri, 26 May 2023 07:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjEZFfr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 26 May 2023 01:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEZFfq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 May 2023 01:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C78194;
        Thu, 25 May 2023 22:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C743260ADC;
        Fri, 26 May 2023 05:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD15C433EF;
        Fri, 26 May 2023 05:35:38 +0000 (UTC)
Date:   Fri, 26 May 2023 01:35:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
        linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/3] compiler: inline does not imply notrace
Message-ID: <20230526013534.76e5b613@rorschach.local.home>
In-Reply-To: <D4B1FB24-C351-411B-8A40-4DAFE95FA921@gmail.com>
References: <20230525210040.3637-1-namit@vmware.com>
        <20230525210040.3637-3-namit@vmware.com>
        <20230525222844.6a0d84f8@rorschach.local.home>
        <D4B1FB24-C351-411B-8A40-4DAFE95FA921@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 25 May 2023 22:17:33 -0700
Nadav Amit <nadav.amit@gmail.com> wrote:


> > FYI, I have a patch queued (still needs to go through testing) that
> > already does this ;-)
> > 
> > https://lore.kernel.org/all/20230502164102.1a51cdb4@gandalf.local.home/  
> 
> Ugh. If you cc’d me, I wouldn’t bother you during your vacation. :)

I'm currently passed the vacation part and now in Taiwan for work.

> 
> I think you may like the first patch in my series to precede this patch
> though as some of the function I marked as “notrace" are currently “inline”.
> 
> Let me know how you want to proceed, so I would know how to break this
> series.

Currently there's a nasty bug in v6.4-rc3 I'm fighting where I can't
proceed on anything until it's resolved. But I could also just pull
your first and third patch too. I'll let you know when I'm finished
debugging.

-- Steve
