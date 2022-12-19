Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED1565139F
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 21:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiLSUHy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 15:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiLSUHx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 15:07:53 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A951401D;
        Mon, 19 Dec 2022 12:07:47 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id d185so9899363vsd.0;
        Mon, 19 Dec 2022 12:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYnmq6YUKA20HwARN8JDq4iYCZXHUrcLPE+3+zJtSe8=;
        b=i7/Vm7xSYqsqXh54mibJCti0pLzVoIhTVNddh7lRN0PaJyiiHTO4Z7mude3UV0x7sH
         o9qJhBr1EMi3JrKMpCs8dfVw1tDc8LEX5bz5p4JfoIu+Ubfgmh2KLFsiyDsdN9LK5h9S
         aOXB8UnDWohgvlcqIRFBfBQRnsKw2VLOyjNl8v1FOkym3DleDRlleC7/ecr0ObQkq0/d
         bX+25KX8LYxq8C5hEy9LaOcjKyOoSGx0GHzfLt5aim0Q4EAjFbBFvrr2SGp/9bk59SVq
         y5UjOIAs6LYPpNHdRv8bg+UukznF+pTPetGwYEAkB5Zy/z1/A4C87gLx8VgzW2iGo+wI
         rU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYnmq6YUKA20HwARN8JDq4iYCZXHUrcLPE+3+zJtSe8=;
        b=JnueslVNmEQgvLo2CY3Jp2HyptB7HD+BYfFtQOs+8QXkUnpQHHAzwLwpCuvzVWl7W8
         is18xxZLhtGpmEKncuI7neSjk/se9NP9enePHx0UmdJ+7OUDRK8TVqbqP780lnP21loS
         vyGJbRljZ61aj+cefsWC3nPlSKLYCgv8lgxAP6PAGW3GUnpno17ay29G0XigoTlmr7zI
         haL/cFAwJ5WId7IriOHwegV6DZ/Ijttf04nER9bJODcVYG8WD2HoP+3P2e4KngdnabYJ
         Zh8/yEDg7DBSGRHSparA72NA11mYPMH2WRJDqMK3u8KpglOMGOkCYMoRx+XrEkGXl3hg
         H3IA==
X-Gm-Message-State: AFqh2kotILl18my3PCpdXMDuvFABhI0du86GYf9gel0FnNOByc8xXI66
        OkJiui55AA4YVHevrcLEnpI=
X-Google-Smtp-Source: AMrXdXsDzqfCRNTjjkXS9BQJxwqeAJtBOMlBh19EFdlQeLXBnuR5h323MBGGcxoDg51DibTTYx3UBQ==
X-Received: by 2002:a67:ce0f:0:b0:3b1:2b40:5213 with SMTP id s15-20020a67ce0f000000b003b12b405213mr3344235vsl.18.1671480466748;
        Mon, 19 Dec 2022 12:07:46 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id f19-20020a05620a15b300b006ce9e880c6fsm7411568qkk.111.2022.12.19.12.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:07:45 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 03F3527C0054;
        Mon, 19 Dec 2022 15:07:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 19 Dec 2022 15:07:45 -0500
X-ME-Sender: <xms:jsSgY0ojvLm7TIu-u2TE2uN8iclnqUtfCMI_16BTaJMdWGvfFYTZ7A>
    <xme:jsSgY6qe_Ri5glkk5NoXAIucmMxftcKH1ppeLs9jyapeQdmxFjBdIAjGRcSu7JaD_
    MecFZeM1QcC8TxNzQ>
X-ME-Received: <xmr:jsSgY5OioSgk_BcF-aXVqU4BSBJo2Avgay0Xy9QY1Y5H7kg3RJq7gDnz7Xo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:jsSgY762SSN7v6Pzv-VGd87-2abzx7dDKC9XIdbQqzAY2xxHqZuKMQ>
    <xmx:jsSgYz5H_be3042jrN2GTBQ1QHozCQlIecQ4gj_N6JUpRt_6oHxloA>
    <xmx:jsSgY7il59bocHi9-VrNS7BZ7WlKqYJ17MAffEn8q2HktZgl_uFmog>
    <xmx:kMSgY54Eevnn0AieiuJIS2E7QOAoD7TTwJ-HVt0MktSpliy60jajy7YwtGc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Dec 2022 15:07:41 -0500 (EST)
Date:   Mon, 19 Dec 2022 12:07:25 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 05/12] arch: Introduce
 arch_{,try_}_cmpxchg128{,_local}()
Message-ID: <Y6DEfQXymYVgL3oJ@boqun-archlinux>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.154045458@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219154119.154045458@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022 at 04:35:30PM +0100, Peter Zijlstra wrote:
> For all architectures that currently support cmpxchg_double()
> implement the cmpxchg128() family of functions that is basically the
> same but with a saner interface.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/include/asm/atomic_ll_sc.h |   38 +++++++++++++++++++++++
>  arch/arm64/include/asm/atomic_lse.h   |   33 +++++++++++++++++++-
>  arch/arm64/include/asm/cmpxchg.h      |   26 ++++++++++++++++
>  arch/s390/include/asm/cmpxchg.h       |   33 ++++++++++++++++++++
>  arch/x86/include/asm/cmpxchg_32.h     |    3 +
>  arch/x86/include/asm/cmpxchg_64.h     |   55 +++++++++++++++++++++++++++++++++-
>  6 files changed, 185 insertions(+), 3 deletions(-)
> 
> --- a/arch/arm64/include/asm/atomic_ll_sc.h
> +++ b/arch/arm64/include/asm/atomic_ll_sc.h
> @@ -326,6 +326,44 @@ __CMPXCHG_DBL(   ,        ,  ,         )
>  __CMPXCHG_DBL(_mb, dmb ish, l, "memory")
>  
>  #undef __CMPXCHG_DBL
> +
> +union __u128_halves {
> +	u128 full;
> +	struct {
> +		u64 low, high;
> +	};
> +};
> +
> +#define __CMPXCHG128(name, mb, rel, cl)					\
> +static __always_inline u128						\
> +__ll_sc__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)	\
> +{									\
> +	union __u128_halves r, o = { .full = (old) },			\
> +			       n = { .full = (new) };			\
> +									\
> +	asm volatile("// __cmpxchg128" #name "\n"			\
> +	"	prfm	pstl1strm, %2\n"				\
> +	"1:	ldxp	%0, %1, %2\n"					\
> +	"	eor	%3, %0, %3\n"					\
> +	"	eor	%4, %1, %4\n"					\
> +	"	orr	%3, %4, %3\n"					\
> +	"	cbnz	%3, 2f\n"					\
> +	"	st" #rel "xp	%w3, %5, %6, %2\n"			\
> +	"	cbnz	%w3, 1b\n"					\
> +	"	" #mb "\n"						\
> +	"2:"								\
> +	: "=&r" (r.low), "=&r" (r.high), "+Q" (*(unsigned long *)ptr)	\

I wonder whether we should use "(*(u128 *)ptr)" instead of "(*(unsigned
long *) ptr)"? Because compilers may think only 64bit value pointed by
"ptr" gets modified, and they are allowed to do "useful" optimization.

Same for lse and s390.

Regards,
Boqun

> +	: "r" (o.low), "r" (o.high), "r" (n.low), "r" (n.high)		\
> +	: cl);								\
> +									\
> +	return r.full;							\
> +}
> +
> +__CMPXCHG128(   ,        ,  ,         )
> +__CMPXCHG128(_mb, dmb ish, l, "memory")
> +
> +#undef __CMPXCHG128
> +
>  #undef K
>  
>  #endif	/* __ASM_ATOMIC_LL_SC_H */
