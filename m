Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 036DAD4EC4
	for <lists+linux-arch@lfdr.de>; Sat, 12 Oct 2019 11:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfJLJvD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Oct 2019 05:51:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:59821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfJLJvC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 12 Oct 2019 05:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570873814;
        bh=8pjS8qqP1wCmF9jdsKwpdm/zvDW8dZCWsbuGTUYmHnw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=J6CKZ22z3cpZ+/zpyRdj0H0uRJ/h7sj9IgGBbkjmN6qL2X2ARZIdDqpJzufjDVaR1
         uGmCRhNhLGwwLdQCLythOpnfYpv8PEvyP/qgm1AFgnAATznFGOLmT/lqRCPATFTE0B
         4v750SP85bljN9qKjtWA813iPaD71LWPNRVf6yNg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.179.223]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1iAOLl3LOK-008rpL; Sat, 12
 Oct 2019 11:50:13 +0200
Subject: Re: [PATCH v2 23/29] parisc: Move EXCEPTION_TABLE to RO_DATA segment
To:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20191011000609.29728-1-keescook@chromium.org>
 <20191011000609.29728-24-keescook@chromium.org>
From:   Helge Deller <deller@gmx.de>
Message-ID: <8b3c27ec-9880-5957-a802-ca740d9ad6c5@gmx.de>
Date:   Sat, 12 Oct 2019 11:50:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011000609.29728-24-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OW210CNt72Zupg9+ou7uinpWv/FzSz2oE2Zp/PdnIFvmfis7zNJ
 P3Rp9iclPc+rsBMguDEUPJQm8Yn1SvGGtGHcdrp+KJhkV5wbrDyLG2gmCL/OgLYlrwnF1m9
 LNy0UJ3GCHEE7hTl/1RD6xsBIN/bKRXCoTcyxTI5LmvAywZVxlNm8MA7F9Ig8LsAryEJ8IL
 JZhR1dSDqg/a+ayH7Komw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pZ5nxAfIR7w=:h5OstQK89PxInzAY8LE9ch
 H7OkoHcI9jbhXK+JS9guTm/NHtR62occBkO2mpsMXM8CRvDkBO5bcVH80Rezb+BmCmqBwYfVr
 V9LY8lwOb62BQ5FbznS9gCvsa4J5A3qTQWXVAw4wSBb5Hd9B3JGDEXDr5Y3XMCtYLQMgkW4qt
 UWFawktUY/KQKoKp+wdPI1/x/iM5UslaPQ4IQyERqet9S71/be4PGuAnJO/DM7FdX+L5dpZgy
 yw2mqZ6hWfdIBGL5Uli0aQsNW1nVOakK5BMZh/snQdA7K/AKGcofWf2CoWFg+U+WlIYsMk/7T
 Pzt5/15B64o3xwlr8EB4l3C6YfTL15GeKpFCRSVGlmMZL5lUOjPbfWrdr0add2D4nluYZNmWF
 YaxZQqp3IqfSOo/jJ8ej3lvbXrz4BqLpF+4wdwuC3JClJytzQE1Y+Fu1QQMCbtKHmONRtduG+
 Tix1xFhpsARj+Hd2pI71XlP6WhLK2+A5euQ73Xbw3/tDBssMvJFvMc0ezsel0B1PPxrxP7Bug
 OcudSoOVhia9L7wKmfSCpQrhRPtOa5tL5L/zOXxshqukOAg31BZ1xu9MwYGbuEmWjVRQq3/4r
 TWrK0Eb5R0YnUO1S6wcz2zID6JB78b3jejElNf0Ale1zAFgn5koeth7M3dmWS7foWtFTRuL7d
 hggTfyvRmEpLI9pfmFwF5jWvX69HM6DjvKPNRE9Pkg+UEX2eXnp2ARrw9L7VQr/BtrgihZ/ij
 QZkJHTz+MgGUWmwhriw0JccXhLLWPMS+bx3//Vjhvw0611mJyt26SPB72B95yXJPhY9g0Ln/Q
 aE5s0mL/GSWLKI8M2K9L1HJL/gQOzXAY+KfriiZSMaYuUY1797t7U1bxucplHHjUR7TXa8mcE
 zrwtR+BN+Qwc4hPsHs15Gx+20e/RdwD7K+sTSjBn1nny76pXAKhWTNAboDLi3aaQYTbkngsys
 MFOXSHRSCJCMyaVreP2DCY8T/bxMAvUQceQIzuBE+/PUhZ8LQNSPpuKgqwLHuNLKngTD6xwpV
 XJuQCX2nL7gOekbu2d+u2r/C4DtxPB3BQowgPWG0MJpFwel/FxWvZ47PMkHn3Qtv4tBf68QNz
 N17bNoir8utOLCgGgm/z/gnQ2uVeWeKTFrRTR76F6mWi+nUkajc+Mee+U3ePQ0uyZAzVympCm
 aC0lcaNBAZ6cO/enINP3xeoyXFBf3SzdmzJbOAWaZnFa1gyem2qJbi/FPSUkuM5gc13cDiQeR
 YJ4EyjmC/J5gPlCSwJyuiuu/+yaa/hcDpx1jhRQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11.10.19 02:06, Kees Cook wrote:
> Since the EXCEPTION_TABLE is read-only, collapse it into RO_DATA.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   arch/parisc/kernel/vmlinux.lds.S | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)


Acked-by: Helge Deller <deller@gmx.de>  # parisc

Helge

>
> diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlin=
ux.lds.S
> index 12b3d7d5e9e4..53e29d88f99c 100644
> --- a/arch/parisc/kernel/vmlinux.lds.S
> +++ b/arch/parisc/kernel/vmlinux.lds.S
> @@ -19,6 +19,7 @@
>   				*(.data..vm0.pte)
>
>   #define CC_USING_PATCHABLE_FUNCTION_ENTRY
> +#define RO_EXCEPTION_TABLE_ALIGN	8
>
>   #include <asm-generic/vmlinux.lds.h>
>
> @@ -129,9 +130,6 @@ SECTIONS
>
>   	RO_DATA(8)
>
> -	/* RO because of BUILDTIME_EXTABLE_SORT */
> -	EXCEPTION_TABLE(8)
> -
>   	/* unwind info */
>   	.PARISC.unwind : {
>   		__start___unwind =3D .;
>

