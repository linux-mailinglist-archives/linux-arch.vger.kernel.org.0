Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771D377FE4E
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 21:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbjHQTFJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 15:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354644AbjHQTFC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 15:05:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBE230D6;
        Thu, 17 Aug 2023 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692299070; x=1692903870; i=deller@gmx.de;
 bh=R6FahYjMjq3IcNebCctTGPYLvIg8dED0+aUfIoATJT8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=V/nPTGXx4qnZHiHLKJxJ+6MDcixcr6nO88bdvihvvSn61dUJlJrTgmmJG1VUBNu7qXdA2F4
 ocyNUy0Ote/HT7BKAQYx3yhn1zuTDr+03SgnqeHcZZvoJiospwqYiHNUu1+uOd3lwmE2FyG/1
 JdBiKqC5OP6CkazPdGAbr0qLXKpfnJW4oN10A0+bePVhRm7HQdHg6x4lm5jCCkBa6d1/YElU9
 K68porNruNJfBJajKRNnHz+HZgX370VbaDuzUhojW6X/E1eE4BfMQ2l1qsA+7R40ojg4R0HeR
 fvymJiAf85odG8TNMCMcGOvFAkvYYA4YXbXqZAl2uLotUp0kLxfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.151.122]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUs7-1pZfYF1qTB-00xqnP; Thu, 17
 Aug 2023 21:04:30 +0200
Message-ID: <133d22a6-5fd2-49a0-50f4-7018397bdcef@gmx.de>
Date:   Thu, 17 Aug 2023 21:04:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/9] parisc: Remove <asm/ide.h>
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <linux@armlinux.org.uk>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1692288018.git.geert@linux-m68k.org>
 <5ea78d9c54cf94c6074fde6f277bb7a08bfe8d08.1692288018.git.geert@linux-m68k.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <5ea78d9c54cf94c6074fde6f277bb7a08bfe8d08.1692288018.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4pBi3eR0csmxEpYzr6TBmDopGdzbTBAizNpH1Rem4KR3poYpXQI
 0bdxkebh5IacK/CSmBcrqu4JrCZwQxeaz2/xVLtVO1CNMkstItNM1OsvbKu8n5HO0aU9KdV
 ITzVZMGJOyd8Yn9W2TS+gsJWBkvNbMPQNCpb4JRz39clTnhcHp/Vzt2cToyxJwHnh+OjSkA
 luurJWY1Iwl8wsV+jfp6w==
UI-OutboundReport: notjunk:1;M01:P0:H8A+9oAUqKU=;PMueJpoedjum8wcq5H4m9VrHYDl
 UJH7dvM78TjuIQ0xddxpyrzHvGuUe8Svfmu9hW9LQiBBNDyRctpJvn9jIgaoAcEmCeq1pKdB/
 mjnXH4RAagHgr5Zm1Ti2zoHJy0pe1bcJ/WsfOsjwNTIr7cUnvLCFF4hPdyL0TYOcHlmXnEn19
 isgLeFVo6O1B1MoCivuSY3bKCjnnKH5N+fKOqrQtNxopnptx2gSBBqrPGOS6zMKHizoXDiWj7
 lCqiPNLaJudv09rTK1vaFvtUqhm0GSvU8FV+S53b2LVTv3T6ab/GFjW4PTR0k4vFBlrCFUrfI
 9D0VNcdljK1iN7yw8cqCxYX0p6KJ7FQKeQC4sXT79+NxFhUV17sZ6zCMBgsni0HklD8Wwpg0S
 8qwpJkoovAcmdYPaPtRlRkqVJ3Mn8N6oXjLdAUktx7tsh5sDY9mkOTaeaHH5aGFRtBlNsXXd+
 BxBEPPvLbYlRSJI9JcrN46U2NzdBVM0LTOPvJ7UGMaE/ksWWkSBUEP8Xlvjfj036aWfCeZm7c
 GgH+gwuYyV4cNVhyCjs7b2Hu0PPRjnK9EM91zTAWop5zIbCBf31RpVHc4AAHOpWGN1a6o0VKR
 cdCDHt451NC8sArgYu/rRMdPforNd0eKR91ZR5TbKIYdrmxdZ0lCW5+fVSvRbQJfSzY4E44fD
 hRaX+CsTbuUGgdYkhjOWF/RqFpfQnbcFEEy+Hzs9+cm+2Z/IMzooL3IxTsynZNS8fnQF0bPL3
 BtUjCSxaNvarpYnZmaJdGiFHq8E07rdx/GtKz4mTDJxI0JDHO9znm1Mpgf9TziyrxTQECP3aC
 K/Gm84l8dT25UjjwRgK8hSXDAewvI+QVwktwgPJ/Q/Qk4+o4gSkqAlDp0ctojvIIkv8QZHmRH
 wLOejEMElPdexgLDQPXTpJPh5VdnJ64eICFUjGKXeu1paR2DB7crFIRymHip2kq6tKWHQxZBZ
 sZtImOr5UBCG1Tlwbysh7f93k3k=
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/17/23 18:07, Geert Uytterhoeven wrote:
> As of commit b7fb14d3ac63117e ("ide: remove the legacy ide driver") in
> v5.14, there are no more generic users of <asm/ide.h>.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

> ---
>   arch/parisc/include/asm/ide.h | 54 -----------------------------------
>   1 file changed, 54 deletions(-)
>   delete mode 100644 arch/parisc/include/asm/ide.h
>

