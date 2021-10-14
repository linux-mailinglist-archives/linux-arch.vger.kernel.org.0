Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827AE42D765
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhJNKtT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 06:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhJNKtT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Oct 2021 06:49:19 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEC1C061570;
        Thu, 14 Oct 2021 03:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x2jwRKorCNgoPpdzs8qq0S06D6G51+ysL6On8xrWlx4=; b=CfPcr/fStuSF0qZNy/VAv+H3s7
        L9YGbVbhEWRfVBhVxZVY/eeeWIktt/E96qgOPsWQf2q8SWy8Yuqhx+EOSKtN7ZB7LM0c/Vqf98C8T
        Mll/EkUeNf4GOKHpgFo0Mcd28if7n9ivKKtPDD8B34uKiuA/Yc9INrI3SPLwTmaAcL6Ny66G6KQA2
        ueU+cbMrsxFe4DsyT/pMVKQYn47syi2Ju8tbSkMs+9+RzoHuv8Ez43s+wn9Jm3tiL/ajgeGpGQELC
        EOM+xu+3yOpt0u9VR5DnlW9SJHMc8VeMf2m1eByX6BvLA5HfKmH6PYJJuv3B3vA14vwlfXmvDJ5hN
        1FeoWXfg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55088)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mayG7-0001Bc-CD; Thu, 14 Oct 2021 11:46:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mayFr-00025O-R6; Thu, 14 Oct 2021 11:46:31 +0100
Date:   Thu, 14 Oct 2021 11:46:31 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, jannh@google.com,
        linux-kernel@vger.kernel.org, vcaputo@pengaru.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com,
        mark.rutland@arm.com, axboe@kernel.dk, metze@samba.org,
        laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, jpoimboe@redhat.com,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        vgupta@kernel.org, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        nickhu@andestech.com, jonas@southpole.se, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, hca@linux.ibm.com,
        ysato@users.sourceforge.jp, davem@davemloft.net, chris@zankel.net
Subject: Re: [PATCH 5/7] sched: Add wrapper for get_wchan() to keep task
 blocked
Message-ID: <YWgKh8JRYjDpU9zW@shell.armlinux.org.uk>
References: <20211008111527.438276127@infradead.org>
 <20211008111626.332092234@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008111626.332092234@infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 08, 2021 at 01:15:32PM +0200, Peter Zijlstra wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> Having a stable wchan means the process must be blocked and for it to
> stay that way while performing stack unwinding.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk> [arm]

I will eventually get around to test this once I've caught up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
