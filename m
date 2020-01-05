Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A0B1306D0
	for <lists+linux-arch@lfdr.de>; Sun,  5 Jan 2020 09:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgAEIjc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Jan 2020 03:39:32 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:34778 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgAEIjb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Jan 2020 03:39:31 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 47rBrt2jPnz1qql3;
        Sun,  5 Jan 2020 09:39:26 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 47rBrt1Dkgz1qrjv;
        Sun,  5 Jan 2020 09:39:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id oMzHkyaTNvkK; Sun,  5 Jan 2020 09:39:24 +0100 (CET)
X-Auth-Info: +JI14q7M2PNLVqZ/I6XWB6XjdmLUJ9plZ0uoorJ1IXaHYIJ3OSz+LF8MHwk9ZBXv
Received: from hase.home (ppp-46-244-163-176.dynamic.mnet-online.de [46.244.163.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun,  5 Jan 2020 09:39:24 +0100 (CET)
Received: by hase.home (Postfix, from userid 1000)
        id AF7D810377F; Sun,  5 Jan 2020 09:39:23 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     guoren@kernel.org
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Anup.Patel@wdc.com, vincent.chen@sifive.com,
        zong.li@sifive.com, greentime.hu@sifive.com, bmeng.cn@gmail.com,
        atish.patra@wdc.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
References: <20200105025215.2522-1-guoren@kernel.org>
        <20200105025215.2522-2-guoren@kernel.org>
X-Yow:  Yow!  I'm out of work...I could go into shock absorbers...or SCUBA
 GEAR!!
Date:   Sun, 05 Jan 2020 09:39:23 +0100
In-Reply-To: <20200105025215.2522-2-guoren@kernel.org> (guoren@kernel.org's
        message of "Sun, 5 Jan 2020 10:52:15 +0800")
Message-ID: <87o8viwb44.fsf@hase.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Jan 05 2020, guoren@kernel.org wrote:

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d8efbaa78d67..3d336f869ffe 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -286,6 +286,15 @@ config FPU
>  
>  	  If you don't know what to do here, say Y.
>  
> +config VECTOR
> +	bool "VECTOR support"
> +	default n

default n is the default.  Did you mean default y?

> +	help
> +	  Say N here if you want to disable all vecotr related procedure

s/vecotr/vector/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
