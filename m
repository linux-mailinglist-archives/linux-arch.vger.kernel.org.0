Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD3B68C3F4
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 17:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBFQ6T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 11:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBFQ6S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 11:58:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C72279E;
        Mon,  6 Feb 2023 08:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675702686; bh=oduEQSmX5w2TdFT5GxpWGp4vTr2PGe2Au2vMj0xJ5So=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=jGVdQH2lc02h1rgNqJc0l4Y80CfKI9LK6xHbRC2J/br744OD+MGmPrVF37cufr2hQ
         yJTzjoueguDhAo2B1csqRngqA7zMIEytzGx96gsLLzcFNy08WUUaauSYVIZSSwT0ei
         ulAPZQchwSxLJ/mmyJJ+mpKFFWIv2BxukpLPr6FAPI1LWZRtoUyP7edsMzlmeYjyC8
         BAfhNgR8H3ENTDvsmLyMghQpQxNtBKb+jLGEikuIcuk3XCjgt2HVAM94Wd9LrGytCx
         6woeiUzl20u8HfPpBliKla8sJt4T5fpDs9/9C/ypYfCrGsEmIeEQe3acQYL4Kw+grs
         4HcLxDeOZiPug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.187.227]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ykW-1pV7Dk22L8-006Au1; Mon, 06
 Feb 2023 17:58:06 +0100
Message-ID: <84b1c2e4-c096-ed19-9701-472b54a4890c@gmx.de>
Date:   Mon, 6 Feb 2023 17:58:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l0w4M91DwYLO3N@ZenIV>
From:   Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 08/10] parisc: fix livelock in uaccess
In-Reply-To: <Y9l0w4M91DwYLO3N@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VFAdDPOyDsZ+gDOfjL++mZzEtC+e2v/KCjg8uQsf0yjF1YAzaMS
 oXW29IrTBTtPzkOTcXxudlWjrhGfO1ez3hBLeyfLw2/Z0WaXrXMv7w5zk4brciWkWNAVj/v
 2eu8fda/vTBeLfXmUNcSX1hbCAIv8EKxS//63b0kTRVmu0h5ndbdvcdcQ/q/cL7nrZwQpu6
 Stb8GCjAJJ4AQa7UKcYFw==
UI-OutboundReport: notjunk:1;M01:P0:KkzFdp2tKvc=;5EOddTxTxg9vhOdXmEOZP2I+Hdo
 8MYBzo3Bxhn6pstHx7hVY3z0DOk1/GKvEDMafgAHfPK87L6/JHxNfu2GbFOTnfvCOtfvt5S+J
 OHmBby6u5bHxMD7BhvLQ6bewKauY86xpZ8/lngugRbSc1GwJFtyBaxBGTLWx596I1+yIDp75V
 1eftEsNOiAj1668aOJhkDOcNlgXNKMfc9xcfmTdXUpkd+m0zaI4C/YdFdQxgPn7NqaUHoDJ7a
 oZGaqvwdsPUzlsLU4SeWCOmSeiKTHm0R3rcYSqHypUBzck+ubTNUY+HGIfmZitkNPgQUu5fxs
 1svaHATbHtklwgcs4LbUlmsGW6YrshS7doWAQffJU5NoW4DE9USmOO2aL1QWKD+SdZRJD3uKe
 wgJdpLf9MoMixQqF1r/0ECY/lQUfRZZlqxsd+PVJLypTNfZ7NAgJ7437aFZmoZ4Rkm6x5ao1P
 P31aCzGf78iKqX9BAgw1SO+fTo9z7V0ZSxJILNRpAuleT+HAp2+sPWGk+P1DGh+zgHUxeRxiB
 AXoN1pJP+uNu3hQCpxpJ6Z8ol0AusGOFa0nudlLoZ1WIyk5d9qBtkBReX/P/3OmOT1kORr4ki
 p1jONZSd2R/dTgC/HjSo+7XH6EBT7VytCg0JOgMich2CCEh6ppsrNnE9sJiFbVJhewjkC4cAH
 ELy1bEvkQdy2XK6XwDq2OD3qJLes8G9yNBABM9DJjWaIjgpVKLYM+iN7r7zdGVECSm9Vhu/xq
 FQl3HOIg5OSBUq7rJpzcC4vtT/iNp1HlzwnKnXc8Soz6pbQ6CfzvAKPlaJoBEpv909olkJCEF
 NdfBleQ3ocnrQtCmruOPdxI8fYjSvrEYEsRW6cXaySAymu/vBbKd8FctXmANynq2NFRRnfQvM
 MOnt5h21CVl51M3ex2UpkfwNXr8nIVabnB8w6CFJ92ViWscwWypuXCIJ4+NHu7Vxu7SOdHBhp
 0v82qITXH6SIFaNqh59zWNPc2ss=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Al,

On 1/31/23 21:06, Al Viro wrote:
> parisc equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY h=
andling"
> If e.g. get_user() triggers a page fault and a fatal signal is caught, w=
e might
> end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing any=
thing
> to page tables.  In such case we must *not* return to the faulting insn =
-
> that would repeat the entire thing without making any progress; what we =
need
> instead is to treat that as failed (user) memory access.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   arch/parisc/mm/fault.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
> index 869204e97ec9..bb30ff6a3e19 100644
> --- a/arch/parisc/mm/fault.c
> +++ b/arch/parisc/mm/fault.c
> @@ -308,8 +308,11 @@ void do_page_fault(struct pt_regs *regs, unsigned l=
ong code,
>
>   	fault =3D handle_mm_fault(vma, address, flags, regs);
>
> -	if (fault_signal_pending(fault, regs))
> +	if (fault_signal_pending(fault, regs)) {
> +		if (!user_mode(regs))
> +			goto no_context;
>   		return;
> +	}

The testcase in
   https://lore.kernel.org/lkml/20170822102527.GA14671@leverpostej/
   https://lore.kernel.org/linux-arch/20210121123140.GD48431@C02TD0UTHF1T.=
local/
does hang with and without above patch on parisc.
It does not consume CPU in that state and can be killed with ^C.

Any idea?

Helge
