Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48248720A82
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jun 2023 22:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbjFBUon (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jun 2023 16:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbjFBUom (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jun 2023 16:44:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A1E43;
        Fri,  2 Jun 2023 13:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1685738571; x=1686343371; i=deller@gmx.de;
 bh=EtVxm1q0lPS2fVvNyBPOHcvxtqGybgS/jj5fhYQ0wso=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=av33vA0fDg8Z/UAXc/ThaoXut1CaK/sOxgD2P0ojBoj1qIDA/9tulc7N+nnN6AuMCaWT6U/
 V6Xt0OrS0sLjGxFvN2fm4pUcp/bWMDm9Imu6k2JfFnUNwy41AyEjCqDEuCTeluDPtxFELeRAn
 hU5hRGcxqURtCcKKwm7u7ixIjZCt8X0Ss5YuIZBZYUyCzfYFqxv+MQIVEh4Vm9ICHIR26NfQR
 4geRw6TNt/0Kl4FxQy5jMWncprbiojBXek8gHVsXaBfI6YyVzcG+Y8doDS53puRqAdry8616+
 GX//FxMVoV+JAv49G9yedD8DUktjiPFu78LE1Bo309piw4qsYx4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.56.61] ([109.43.112.4]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGRK-1po4AH280s-00JHiH; Fri, 02
 Jun 2023 22:42:51 +0200
Message-ID: <467644b2-48e0-afcb-64df-044bfef1091e@gmx.de>
Date:   Fri, 2 Jun 2023 22:42:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of
 __SIZEOF_INT128__
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>,
        Sam James <sam@gentoo.org>
References: <20230531130833.635651916@infradead.org>
 <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com>
 <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de>
 <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
 <20230602143912.GI620383@hirez.programming.kicks-ass.net>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230602143912.GI620383@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:78zHS8/aoBMFCLCrh8NEXU3+Mi9dUj8jWsvJ4VEVpEUJQXsb9qg
 klluUMDHJMFGtTxpf5yHCCUToer+4drDAQNHQAgVuo2HQCUoRS2JKuO2hlIzeTb22N58bCn
 8yjiDqiZVuqg3gAisVRWVDRtX7Hc6PybceJ1LJSdNjMWHXOtBKBZrzWHSU91N4DfP+8mnyM
 QSAG3bfiqm8ylM/aCgeMg==
UI-OutboundReport: notjunk:1;M01:P0:wkQwUL8WRiw=;/Mf2bbmZX3J4GHZLVevV9vugLQW
 +vevBhHxQxZXsmO+8L6EOG/dEz/8oyfQfnS8wMnRTP+UZkW2Jeh5UROdSqwek1bSDc3hscquW
 juxUK9V8xf9t5FcAQDbZODfu5kKCtEssNh76o1+fCeNL32NLfl+p9rCrk8EvyceKupB9kOtVS
 Zqa1MJ/uMOsRK42oZB0Hk5wiqr1yfjDV9m1LgBSLNNrplu621iX8TL5gcIRsEl/cFBhpwMOdX
 BNtq5HJtd88nea87tEDpT53rNKNsGjzifJ8u6IMd3UP5Adhp6HiJwcPv3ifPV+iBPdBaFoGMc
 4I6d6vqVRkP+le+e27uYMDuej7dMfA1eoefmxqS7+3MXqQfSXrAz5m8YPz6om/C8WdFXNfrq2
 TGEsP1DEsFMCEn9DK5mz9Fs/pyKSmtNBdHNOc6rrjYUJWdFFLgXFqgy0d8kkWPjkZ0BWcCPAA
 9yBVYCRXvrrkoVM35zKJy/wM+uuqmrWbIfAG5Rzyrq5PUPN30TIKWLPiqeCJqIudsXFCrtZlt
 9TPQTfEARXC84lZh93e5TzhkS6ofvWIBL84RG3pXlM+Z/Bfzbx7wyg84PAoAtEi7tC5x4T8lY
 XADZPaMtrDowkFDwq0f2CUNASHYZv3SDuKUaaomM9LkqoheIbfEsA0+x29VcW3Qb4jMEx2cRr
 RcsI5SwGCv/Ze2Ap4CIUYNYyCCL56PiF40vQN9nqQ4Ob9V9afxKnU4T74F5MNIYBTcSeEAm9b
 Dv2PgUjkUMmJWqS6wbLcAD6UVoBWxpixeBRJRZmMd47jiB42ghukw6uBY76L/5M09dUjKMxAc
 NpxBGg2MjVNl/5HupbhQr2chxUVvrYNBGVJXve8gPqdA+pVSM7dNTBufu+I7Ey1TE6xDBhYm8
 Gx8ST0Wd1cxeFWu/AQP5en8Fcs4Xsb39hbqI7LYqcHsqLiMtZAcZowCT5au3GGdPCHmSaa2Io
 N18lvg==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/2/23 16:39, Peter Zijlstra wrote:
> On Thu, Jun 01, 2023 at 09:29:18AM -0400, Linus Torvalds wrote:
>
>> Right now we have that "minimum gcc version" in a somewhat annoying
>> place: it's in the ./scripts/min-tool-version.sh file as a shell
>> script.
>
> Something like so then?
>
> ---
> Subject: parisc: Raise minimal GCC version
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Jun  2 16:33:54 CEST 2023
>
> With 64bit builds depending on __SIZEOF_INT128__ raise the parisc
> minimum compiler version to gcc-11.0.0.
>
> All other 64bit architectures provide this from GCC-5.1.0 (and
> probably before), except hppa64 which only started advertising this
> with GCC-11.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

The patch raises the compiler for 32- and 64-bit parisc builds, but that's=
 OK.

So:
Acked-by: Helge Deller <deller@gmx.de>

Thank you!
Helge


> ---
>   scripts/min-tool-version.sh |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -17,7 +17,11 @@ binutils)
>   	echo 2.25.0
>   	;;
>   gcc)
> -	echo 5.1.0
> +	if [ "$SRCARCH" =3D parisc ]; then
> +		echo 11.0.0
> +	else
> +		echo 5.1.0
> +	fi
>   	;;
>   llvm)
>   	if [ "$SRCARCH" =3D s390 ]; then

