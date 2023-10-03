Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4897B7092
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 20:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbjJCSJq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Oct 2023 14:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjJCSJp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2023 14:09:45 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29461AC;
        Tue,  3 Oct 2023 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SR5hzwt7zM//0GbzM35Ia3E9iKMTwd/DCYDjYKbU5Ig=; b=ZXKjBEaHWD1Qo3XGspilT/vQRg
        vSh8MKQ9EEVH/Y8NPGTsc3bLicNR1GX1Jk1DWEKyfbjeG15aUpxDe1KkKHvl530pl2NYiKE4Ir8w2
        51GClqB+aEqMoGDxbnLBVe7YKZ/9eMGcsN8Q20CzqmAyGjBN0jstAUV2RbXZZVGtmK9NajuC8CXG2
        KQlZ0Yu84WGDTz49172j5CMhbRIPTy0k8zaXqPaYQbR+4imnXzzVcxo+AcTZFeGRoUZ4cObk863xL
        owQMVuoL6KoYdFSEWkE4I+CsqEDHjnSNO1Oq5mM2gj0xFCZbboiv6n6i89hvPnRfPXxUdNtZbCPnD
        xo4KshaQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54130)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qnjpr-00023q-1t;
        Tue, 03 Oct 2023 19:09:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qnjpm-00087H-G1; Tue, 03 Oct 2023 19:09:26 +0100
Date:   Tue, 3 Oct 2023 19:09:26 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Xin Li <xin@zytor.com>
Cc:     Gavin Shan <gshan@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Salil Mehta <salil.mehta@huawei.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH] cpu-hotplug: provide prototypes for arch CPU registration
Message-ID: <ZRxY1l+79XqOHZk1@shell.armlinux.org.uk>
References: <E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk>
 <dd4dee9e-4d75-e1e6-04c8-82d84b28fd35@redhat.com>
 <ZRIU/yFrbFbIR7zZ@shell.armlinux.org.uk>
 <ZRwmj/e+jAXFfvCm@shell.armlinux.org.uk>
 <7aee5021-8bb6-4343-b746-a8417af030a9@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aee5021-8bb6-4343-b746-a8417af030a9@zytor.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 03, 2023 at 10:37:02AM -0700, Xin Li wrote:
> On 10/3/2023 7:34 AM, Russell King (Oracle) wrote:
> > > > > 
> > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > > ---
> > > > > Changes since RFC v2:
> > > > >    - drop ia64 changes, as ia64 has already been removed.
> > > > > 
> 
> If this is RFC v2, we put "RFC v2" in the subject, then people know you
> are sending a newer version.

Sorry, but this is yet another illustration why the kernel process is
broken. Clearly, people do NOT bother reading what is actually written,
but instead make up in their minds something completely different.

This is *NOT* RFC v2. This is RFC v2:

https://lore.kernel.org/all/E1qgnh2-007ZRZ-WD@rmk-PC.armlinux.org.uk/

And what I wrote was "changes **** SINCE **** RFC v2". For those who
find English difficult, this means that what follows is the list of
changes that are in THIS posting that WERE NOT IN THE PREVIOUS POSTING
which was RFC v2.

Thanks for making me even more frustrated than I was.

> People are busy, and your patch could be
> skipped if it appears the same as a previous one.

Yet another reason why the kernel process is just completely broken.
"appears to be". Even when the changes are spelled out. Yes, right,
people don't have time to read. If that's the case, then it's a
waste of time adding a change log. It's a waste of time to add a
commit message. In fact, it's a total waste of time trying to
contribute to a rotten-to-the-core open source project that Linux
seems to have turned into.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
