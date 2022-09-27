Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062295ED051
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 00:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiI0WgT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Sep 2022 18:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiI0WgS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Sep 2022 18:36:18 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FD4F162A;
        Tue, 27 Sep 2022 15:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Wu+E2LhsDDERWJZNkF58udNtKGBkLwAE+je5LgTqdPs=; b=PK/BYKGI+kq/0L1NDEc/bdr+fN
        eJH/k+9MCCmeLqU/c2xbDnUJeUafwg57l6xljtfLqXBp4JavmUijspCA7/xxsck04LS/nAuKxNHi0
        1uExtJhEhUleW8mlBykQe9AiMLCby62bJjIiDii5+oAHpvv6RmArPNAVoTtwBbl9VNFjejmTrvzqn
        T82k/BeAUMlLGnMI9bnfFvAywxI6qnRpanBZHzI8CcVeRu129o/KZ4VEMHV9pdl3n8afTklcyk/GR
        cUCIKLVe6DDH2kvdRrx2hn1wWa7WjgA+6Q6c/kOUL4a5LQ4F9qKzWKyEG7Izz54p0C7LuQL5C2Ut7
        BcpLbUYw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34516)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1odJAq-0002Cc-Ct; Tue, 27 Sep 2022 23:35:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1odJAi-0006RI-KM; Tue, 27 Sep 2022 23:35:24 +0100
Date:   Tue, 27 Sep 2022 23:35:24 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        sparkhuang <huangshaobo6@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Logan Chien <loganchien@google.com>
Subject: Re: [PATCH v2] ARM: kprobes: move __kretprobe_trampoline to out of
 line assembler
Message-ID: <YzN6rH6wOiC8a8sN@shell.armlinux.org.uk>
References: <CAKwvOdnQ4tb7auWqUoF_Mm-F9hiJotaQnP75ZDd6oPJ_1Z4qXg@mail.gmail.com>
 <20220927222851.37550-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927222851.37550-1-ndesaulniers@google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 27, 2022 at 03:28:51PM -0700, Nick Desaulniers wrote:
> commit 1069c1dd20a3 ("ARM: 9231/1: Recover kretprobes return address for
> EABI stack unwinder")
> tickled a bug in clang's integrated assembler where the .save and .pad
> directives must have corresponding .fnstart directives. The integrated
> assembler is unaware that the compiler will be generating the .fnstart
> directive.

Has it been confirmed that gcc does generate a .fnstart for naked
functions?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
