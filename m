Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91AC7426E6
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 15:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjF2NDr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 09:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2NDq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 09:03:46 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550722D52;
        Thu, 29 Jun 2023 06:03:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 66FAB3200645;
        Thu, 29 Jun 2023 09:03:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Jun 2023 09:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688043823; x=1688130223; bh=UU
        HaYOR2mXOloOMHF3WLMCOR1A2U5vkl9suJPqtiWo0=; b=MrZKZHz8n89eIUCcId
        WXghgyhn+F5Y91JfHNG7h6bRVjajE8fTPAAhjd5yTneIb4wXSmpq1LbKXeSmewdI
        sjdK3BzECiJ9VsNHc2PNHRoZhm3xRYAm+niXcO3LaQQU4MhSkHRgNL7KekTbhGST
        XCtAL/9vFB8aEMmwPzbk/lKYaOw3o3ta7pbwYVJoUl4935nDF9T6MZnBnxl2NyE7
        45XG/pQFMaOjg4FsJiuQ0OJjKw2rT3OTyLreg4EK69iWblkKDeRqN9hM0nHAreco
        4RI2C7HjAM7m3bAIxsusNPU7K1/tqKHlRAu78xIkM/MvkFfL8/VzpTp9irh6eiv1
        BUyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688043823; x=1688130223; bh=UUHaYOR2mXOlo
        OMHF3WLMCOR1A2U5vkl9suJPqtiWo0=; b=cw+4bxWp1SCuh1Fepi9QaF0if2xkJ
        4cVNwE6L2Y8B0BZ4j9mhs/w9CTABQ9uk/lLli7KdPcxXX5GNTfzwwEySah2SpLb8
        3Aufg0geWX/HnfgPaOANO2QzCTk7sUuxlOKDej+fIqwnaRnTlWOjf1PvCQRQ1mQ0
        CXujhLdJDB5jYKlNYIPiNMNvbVyuShIxf7Z2hPXbTAnwB8HTZUAxnS+3doFVCZfS
        gmb4I1VMLKW5DeH4sul6m4UUqvsEZj5uqrhNhN+sCrKAZmp5/84QBsLfhkM2pVjK
        QvJS+nuvgBir+CxBeaUMXNbGK4UqHWvJ/CRH9X+edp1kdt3CdxMbNaTXQ==
X-ME-Sender: <xms:LYGdZOq2TpawqJ5rcDQl-TvNYIKOBNcc63CcDTHs0UU3pE4KkHwh1g>
    <xme:LYGdZMo5iIttoKNQaIT32FwSEWYOJDX_-UwXYprTiITOax-dB2xadnn_Y1hKqN7ha
    cHQKsG5M8brTfEdBXo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:LYGdZDNvhDZcJ-jDbXTMaWoNKmBbSBNcy2uRZgtNFh1MzbDGFksadw>
    <xmx:LYGdZN6WMjR_fUrNppdGMumaaDtgzsSApBXQPQgtgxJNMBei27ypFw>
    <xmx:LYGdZN50AYLZULabQ_Jig231bC7Vx4KpoK0e9OOcKrHZim3ZsVHbfA>
    <xmx:L4GdZBqp6nvVSArw-43ExHftquS0CkQLQgd4Fa_QbQ4vBbx75zyQIw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 688DEB60086; Thu, 29 Jun 2023 09:03:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <b31f42c1-4283-4793-b448-f7b9326be5d4@app.fastmail.com>
In-Reply-To: <20230629121952.10559-7-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-7-tzimmermann@suse.de>
Date:   Thu, 29 Jun 2023 15:03:20 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Helge Deller" <deller@gmx.de>, "Daniel Vetter" <daniel@ffwll.ch>,
        "Dave Airlie" <airlied@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, guoren <guoren@kernel.org>,
        "Brian Cain" <bcain@quicinc.com>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Chris Zankel" <chris@zankel.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        "Juerg Haefliger" <juerg.haefliger@canonical.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 06/12] arch: Declare screen_info in <asm/screen_info.h>
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 29, 2023, at 13:45, Thomas Zimmermann wrote:

> diff --git a/include/asm-generic/screen_info.h 
> b/include/asm-generic/screen_info.h
> new file mode 100644
> index 0000000000000..6fd0e50fabfcd
> --- /dev/null
> +++ b/include/asm-generic/screen_info.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_GENERIC_SCREEN_INFO_H
> +#define _ASM_GENERIC_SCREEN_INFO_H
> +
> +#include <uapi/linux/screen_info.h>
> +
> +#if defined(CONFIG_ARCH_HAS_SCREEN_INFO)
> +extern struct screen_info screen_info;
> +#endif
> +
> +#endif /* _ASM_GENERIC_SCREEN_INFO_H */
> diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
> index eab7081392d50..c764b9a51c24b 100644
> --- a/include/linux/screen_info.h
> +++ b/include/linux/screen_info.h
> @@ -4,6 +4,6 @@
> 
>  #include <uapi/linux/screen_info.h>
> 
> -extern struct screen_info screen_info;
> +#include <asm/screen_info.h>
> 

What is the purpose of adding a file in asm-generic? If all
architectures use the same generic file, I'd just leave the
declaration in include/linux/. I wouldn't bother adding the
#ifdef either, but I can see how that helps turn a link
error into an earlier compile error.

      Arnd
