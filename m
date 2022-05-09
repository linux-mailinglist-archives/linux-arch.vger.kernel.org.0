Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8DB51FA87
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 12:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiEIKyc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 06:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiEIKyb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 06:54:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB865235171;
        Mon,  9 May 2022 03:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652093410;
        bh=ZNg4QfBLznxYxqjKAVqw9swhZEDJfkMbCiNoVYmHisU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=N4MLLZWGCb5JNtyC7H95egCjPz1yjApQOartbRPLCvWBD4GanTBMTVZ/KKygDC3hm
         FMg7NWuPppvbmIUuTVH5u5V3HSitKPu6xbE0fhzhoYC3vcDqq4e+0NCewfaVZg5h52
         EInpwNfWxYEEtP9d/4bagku/JusC767uarxkzMss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.155.173]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsIv-1o7Kw12pjb-00stra; Mon, 09
 May 2022 12:50:10 +0200
Message-ID: <97b0e932-1309-edfd-3886-fee1498bff7d@gmx.de>
Date:   Mon, 9 May 2022 12:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/3] termbits.h: create termbits-common.h for identical
 bits
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
References: <20220509093446.6677-1-ilpo.jarvinen@linux.intel.com>
 <20220509093446.6677-2-ilpo.jarvinen@linux.intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220509093446.6677-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zN2+kufeFCrksKVn8ZLSi+Syp9bvVf6OWsAjAyYEa1Ib3x5+K/9
 yqA1aCrRiPgP9b9DJlUpyIZcigck+TrE9epdqVuA3ojwlRLQMadGPx3r1bC7Btb/zStxbrF
 NoC0V3l8L+7ScAKi58Ip1EWrF5H6mWyzVnib/hP8wrxkdreDiQbXHvGQ2iT7Q8fCfKxVwbq
 r5ybGN+aaUIS5yRhGnU1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:94PDWJkNMMU=:BwsTolgvnknC3y15LtPdYZ
 q77U5FGg4DFDbNGdo2GKziDKKE5hz8WLBxdbyGuVG/2zDwRXzfU4L7BtIwmDyDZ9Necz9Z+jV
 MUDRmdXZKagx6cHLi1j79oQnXypgaf9m5/FMm088ClB2ez9ornpNx5W73k5NuhvQ6tXNOryql
 nIyGGtpE1IbWRjr9NfSxGZaIMP7+IggpSLnWOCcRkmDOGjJLoQAY7B2p960/CdL5dcQUN9Ljk
 qff2/DF5edvh04Bv1kGfIntWyQkDV18fkliopxSigXuBTe+Du/Ab7HCAa9/rcU6SAi2RaiLUE
 /nf7MK5AoonznCEk1CpE7NcPZAxN4reG9g52INHH7d4erIMNkY5JIc5b7ZnWhwtR/lfRy5HN2
 dNI6teExhpT63mpQnzSxWoL6S2/81/vTqeKGtbDJIoR69vBzMjHpJceDVrUjRSrg2f+ytGfGu
 H2d1UdIVZ4dX04qYpZ07WuPC1YS6Mm/lYKLLGMMfS5VwM0FbVLnQd7o9mIvc9+dYReqbRuiTb
 snCbGkpSPip9EefktG6wD84sV5sJgJxrBQXSzR4GTj4jUZ8uenlkD0TQE9veRbMVcz4HYmOsg
 Yd/hV66kNyekONn5+S5q1sgNK7j7Om5oqly9mQc0nBvos6+IXaXsZDD+yNJb9+PAOMO5+xc5j
 0xO87NcU7tvQudG29HUKSkhUNn0t+XFR6xcuZ9WCeLe8GMk3U7LRp+iLC6WTjqxsPSn/9v1Fz
 t4EVdHwf6O9+Y/iQ6lIwtoQOxffwQ6JH/Cshp+3evWIp7bn6UqGQaFs6awPYkVVazRhqSOvB+
 5jV9iXh54Jm4v123P4trcF0QrdSuch4TtGpf8M4lovhgncZgMTyziL+NJq784H2TOJ4WbBWZq
 pRG5e8D98p3lMkZAp7nAF+K/YrxZfxRcj3XY1NwGS+fbkhRn4I57Xtn4tyDxuAcoQBzA+WhIh
 Y5CeRlwCeTeUCmprVlG3YwFjaCgWer7ndGh7Ghm/wkLhqmQ6CCy+CETCD5/hyoVEXXol5htSJ
 NCMPp2WlzrQXl6ICzAkT8hjEkoccKicc1eiPz8+Hn+eyHBWs2usF8iQUkv2xtSuNxLNLR1PUF
 6Pxei0sM8iDQyU=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Ilpo,

On 5/9/22 11:34, Ilpo J=C3=A4rvinen wrote:
> Some defines are the same across all archs. Move the most obvious
> intersection to termbits-common.h.

I like your cleanup patches, but in this specific one, does it makes sense
to split up together-belonging constants, e.g.

> diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/inclu=
de/uapi/asm/termbits.h
> index 6017ee08f099..7f74a822b7ea 100644
> --- a/arch/parisc/include/uapi/asm/termbits.h
> +++ b/arch/parisc/include/uapi/asm/termbits.h
> @@ -61,31 +61,15 @@ struct ktermios {
>
>
>  /* c_iflag bits */
> -#define IGNBRK	0x00001
> -#define BRKINT	0x00002
> -#define IGNPAR	0x00004
> -#define PARMRK	0x00008
> -#define INPCK	0x00010
> -#define ISTRIP	0x00020
> -#define INLCR	0x00040
> -#define IGNCR	0x00080
> -#define ICRNL	0x00100
>  #define IUCLC	0x00200
>  #define IXON	0x00400
> -#define IXANY	0x00800
>  #define IXOFF	0x01000
>  #define IMAXBEL	0x04000
>  #define IUTF8	0x08000

In the hunk above you leave IUCLC, IXON, IXOFF... because they seem unique=
 to parisc.
The other defines are then taken from generic header.
Although this is correct, it leaves single values alone, which make it har=
d to verify
because you don't see the full list of values in one place.

> @@ -112,24 +96,6 @@ struct ktermios {
>
>  /* c_cflag bit meaning */
>  #define CBAUD		0x0000100f
> -#define  B0		0x00000000	/* hang up */
> -#define  B50		0x00000001
> -#define  B75		0x00000002
> -#define  B110		0x00000003
> -#define  B134		0x00000004
> -#define  B150		0x00000005
> -#define  B200		0x00000006
> -#define  B300		0x00000007
> -#define  B600		0x00000008
> -#define  B1200		0x00000009
> -#define  B1800		0x0000000a
> -#define  B2400		0x0000000b
> -#define  B4800		0x0000000c
> -#define  B9600		0x0000000d
> -#define  B19200		0x0000000e
> -#define  B38400		0x0000000f
> -#define EXTA B19200
> -#define EXTB B38400

Here all baud values are dropped and will be taken from generic header, wh=
ich is good.

That said, I think it's good to move away the second hunk,
but maybe we should keep the first as is?

It's just a thought. Either way, I'm fine your patch if that's the
way which is decided to go for all platforms.

Helge
