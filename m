Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B452E6A8820
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 18:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCBRxF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 12:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBRxE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 12:53:04 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255121025E;
        Thu,  2 Mar 2023 09:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eRFRdAKKCkKrFRZsWy9LuC4DBvxNzT1igB0iYkh4qY4=; b=AsxazJlL5aMQdzq3bALtZj3jJ+
        grMORkVYB42eeVlp4YA1Kto/yHPLWIMQFH6C69Gr+C5zWV82lx62Huwx5qdfEFTgpOcmaTKblLlVV
        1Ct7dLdAqEsHn/Q/NDw/LTxj0b9JjhT1Q2RmX6KBpjfrsqkAh6i5RvCz1FJraQgqNIFfVCfqHWo9O
        dM/77yDiF9xxQjEoDrvf3qmQRtFVfrYP4AWLm5zAO1lVjwm1MEDUnTqZzHMWAeIWg3fU4F7G7v8JL
        Is/VjpPNtHM8ITqX5kg4yhwS31jVbuPByaOxXgz4D0aySHqAF1mdIM7Xgyvi/d3ICRBj9catIJmJ1
        jDVTVhHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pXn6y-00DMnY-2S;
        Thu, 02 Mar 2023 17:53:00 +0000
Date:   Thu, 2 Mar 2023 17:53:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 08/10] parisc: fix livelock in uaccess
Message-ID: <ZADifInpjw/ziIZM@ZenIV>
References: <Y9l0w4M91DwYLO3N@ZenIV>
 <84b1c2e4-c096-ed19-9701-472b54a4890c@gmx.de>
 <Y/47PMmpLDX5lPWx@ZenIV>
 <e9972a0e-14e6-987c-fcee-005a50d28e46@gmx.de>
 <Y/5Sf3fXn0uOUXTw@ZenIV>
 <39436c4d-f5a2-edd5-24ba-19e4812ea364@gmx.de>
 <215b226f-7ffd-70d8-4e7b-85b37f288062@gmx.de>
 <2646c13f-33b8-1047-7cfe-bf7e394344b6@gmx.de>
 <Y/6G5qCEKh68VOcQ@ZenIV>
 <11cfe564-a620-4d0b-210f-c0525c16a236@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11cfe564-a620-4d0b-210f-c0525c16a236@gmx.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 01, 2023 at 05:00:11AM +0100, Helge Deller wrote:
> On 2/28/23 23:57, Al Viro wrote:
> > On Tue, Feb 28, 2023 at 09:22:31PM +0100, Helge Deller wrote:
> > 
> > > Now I can confirm (with the adjusted reproducer), that your patch
> > > allows to kill the process with SIGKILL, while without your patch
> > > it's not possibe to kill the process at all.
> > > I've tested with a 32- and 64-bit parisc kernel.
> > > 
> > > You may add
> > > Tested-by: Helge Deller <deller@gmx.de> # parisc
> > > to the patch.
> > > 
> > > If you want me to take the patch (with the warning regarding missing msg variable fixed)
> > > through the parisc tree, please let me know.
> > 
> > What message do you prefer there?  It matters only for the case when
> > we are hitting an oops there, but...
> 
> I have no preference on that message. Maybe "Page fault: fault signal on kernel memory"
> is too generic, so I'm fine with any better idea/wording you come up with.

Ended up going with that...  Series reordered and pushed out in #fixes.
Status:
	m68k, riscv, hexagon, parisc: tested by arch maintainers
	alpha, sparc: locally tested (both sparc32 and sparc64 parts)
	ia64, microblaze, nios2, openrisc: builds, but I have no way to test the
resulting kernels (itanic box appears to be pining for fjords and I've no emulator
setup for that, the other three I don't even have userland to test with).
