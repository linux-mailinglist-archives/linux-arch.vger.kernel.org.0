Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52448D8CCD
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbfJPJmr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 05:42:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42024 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfJPJmr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 05:42:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id w14so35102214qto.9;
        Wed, 16 Oct 2019 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tc+bjrFvCm99dkdh8oHRuyC3BtBT5HBjTdr0g9Rtqkg=;
        b=PsAp2aMFrpQeUVfKKIw12to7ciwCj3LHoHmyOPdzFWsswiJ6kXsv1mb0q77oUZ9qPz
         XYR4aS+6mT+8SNy7FCY6OdbupRF8wfSSaVCbkWxwjWhhlcZaNVqvGdsFylj7YJCw2dY3
         ymIFlzkAstc6TGOb5oMPfuAvPNv5aC1kpoODjB98NfomTm0NunbjQ2mn637lIiUuFV87
         0YVQwMmXz1vdwww4bv6fxNRXlCjQeYmGfKTL0Wc3Wl1L5Rxb3o5co9y8fUtDdTFvjdNB
         2lvS7WBkm+s09jacoMVDx0W4liDwPgyf33qVFu7t5K9Ujvzmn8WquTVidiB2gtWe2qwc
         W7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tc+bjrFvCm99dkdh8oHRuyC3BtBT5HBjTdr0g9Rtqkg=;
        b=j4HfzMUrM39YWhCUlfJHrpPsvFuKi93S0jSmQEBkYnIoegFdLj3rAuDElwcwMxGB/v
         ulg3pRfbD6prICC5UP5weFKq6GwYrRb6e94BBHrbL6kjhh3LnHnz0LFHkT7PIwvdEDwS
         apNfUWsTvdBsEOHcGQ0B+2VPYl8EiEVTxZoPZDb9jCHw3I4LEWsarZaJSKQZql4lR9D9
         LsKONEFFr8tVTrpKHpeK1+6lPc9zAoel1HkEopRjhJsvlLjpHnI7b7tmjgd3hTPl1KcZ
         RVTMYvmPtZZ+oVi8LhukbOAJflAbD9Vpjw0q2GVbSTQJ6OdcIfz0ZcAclPGo4wbzXb2O
         qZng==
X-Gm-Message-State: APjAAAUEMB8yyWkTXaI4tzhZYGO+ihmRuwNhFuxkphoryadxgyZ3hQ8C
        aO+VyizMNCgiYNu0lzHLjgU=
X-Google-Smtp-Source: APXvYqwv4OPCbvJ/75Lox4Ir6P4EncPUZZJZylf1we/5Vtb4xrvd19GTx1XCLu0AyB4tvOx1k1Pa+g==
X-Received: by 2002:ac8:7084:: with SMTP id y4mr44279072qto.146.1571218965731;
        Wed, 16 Oct 2019 02:42:45 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p53sm12956733qtk.23.2019.10.16.02.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 02:42:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5433120931;
        Wed, 16 Oct 2019 05:42:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 16 Oct 2019 05:42:43 -0400
X-ME-Sender: <xms:EOamXau1beLCvey8giMNfWrS5u-M98SOlPG_UcrFJ_Y4lqdSeQSxrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrjeehgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppedutd
    durdekiedrgedurddvuddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:EOamXXISM7AZAGOysAqNwFrwskFK4GyvXEMAUK76sMQhyalLITrueQ>
    <xmx:EOamXX9WFyjbGgP8fN1v2SsFAsuaS2nvq57_d3YoSZKkDj0uzpSfrQ>
    <xmx:EOamXT5zY7H9WLM1B_lOpw2bBnMmL1VKQXk25rKbr0sGwMbHc8WAiw>
    <xmx:E-amXT59VT5qlyQTUsleQCVd7IBHXi8qe1VOu-Vf8i4ehTQfx0geLQQ1pB0>
Received: from localhost (unknown [101.86.41.212])
        by mail.messagingengine.com (Postfix) with ESMTPA id 78764D60062;
        Wed, 16 Oct 2019 05:42:38 -0400 (EDT)
Date:   Wed, 16 Oct 2019 17:42:34 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, bp@alien8.de,
        dja@axtens.net, dlustig@nvidia.com, dave.hansen@linux.intel.com,
        dhowells@redhat.com, dvyukov@google.com, hpa@zytor.com,
        mingo@redhat.com, j.alglave@ucl.ac.uk, joel@joelfernandes.org,
        corbet@lwn.net, jpoimboe@redhat.com, luc.maranget@inria.fr,
        mark.rutland@arm.com, npiggin@gmail.com, paulmck@linux.ibm.com,
        peterz@infradead.org, tglx@linutronix.de, will@kernel.org,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 1/8] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20191016094234.GB2701514@tardis>
References: <20191016083959.186860-1-elver@google.com>
 <20191016083959.186860-2-elver@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20191016083959.186860-2-elver@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marco,

On Wed, Oct 16, 2019 at 10:39:52AM +0200, Marco Elver wrote:
[...]
> --- /dev/null
> +++ b/kernel/kcsan/kcsan.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. For more info please
> + * see Documentation/dev-tools/kcsan.rst.
> + */
> +
> +#include <linux/export.h>
> +
> +#include "kcsan.h"
> +
> +/*
> + * Concurrency Sanitizer uses the same instrumentation as Thread Sanitizer.

Is there any documentation on the instrumentation? Like a complete list
for all instrumentation functions plus a description of where the
compiler will use those functions. Yes, the names of the below functions
are straightforward, but an accurate doc on the instrumentation will
cerntainly help people review KCSAN.

Regards,
Boqun

> + */
> +
> +#define DEFINE_TSAN_READ_WRITE(size)                                           \
> +	void __tsan_read##size(void *ptr)                                      \
> +	{                                                                      \
> +		__kcsan_check_access(ptr, size, false);                        \
> +	}                                                                      \
> +	EXPORT_SYMBOL(__tsan_read##size);                                      \
> +	void __tsan_write##size(void *ptr)                                     \
> +	{                                                                      \
> +		__kcsan_check_access(ptr, size, true);                         \
> +	}                                                                      \
> +	EXPORT_SYMBOL(__tsan_write##size)
> +
> +DEFINE_TSAN_READ_WRITE(1);
> +DEFINE_TSAN_READ_WRITE(2);
> +DEFINE_TSAN_READ_WRITE(4);
> +DEFINE_TSAN_READ_WRITE(8);
> +DEFINE_TSAN_READ_WRITE(16);
> +
> +/*
> + * Not all supported compiler versions distinguish aligned/unaligned accesses,
> + * but e.g. recent versions of Clang do.
> + */
> +#define DEFINE_TSAN_UNALIGNED_READ_WRITE(size)                                 \
> +	void __tsan_unaligned_read##size(void *ptr)                            \
> +	{                                                                      \
> +		__kcsan_check_access(ptr, size, false);                        \
> +	}                                                                      \
> +	EXPORT_SYMBOL(__tsan_unaligned_read##size);                            \
> +	void __tsan_unaligned_write##size(void *ptr)                           \
> +	{                                                                      \
> +		__kcsan_check_access(ptr, size, true);                         \
> +	}                                                                      \
> +	EXPORT_SYMBOL(__tsan_unaligned_write##size)
> +
> +DEFINE_TSAN_UNALIGNED_READ_WRITE(2);
> +DEFINE_TSAN_UNALIGNED_READ_WRITE(4);
> +DEFINE_TSAN_UNALIGNED_READ_WRITE(8);
> +DEFINE_TSAN_UNALIGNED_READ_WRITE(16);
> +
> +void __tsan_read_range(void *ptr, size_t size)
> +{
> +	__kcsan_check_access(ptr, size, false);
> +}
> +EXPORT_SYMBOL(__tsan_read_range);
> +
> +void __tsan_write_range(void *ptr, size_t size)
> +{
> +	__kcsan_check_access(ptr, size, true);
> +}
> +EXPORT_SYMBOL(__tsan_write_range);
> +
> +/*
> + * The below are not required KCSAN, but can still be emitted by the compiler.
> + */
> +void __tsan_func_entry(void *call_pc)
> +{
> +}
> +EXPORT_SYMBOL(__tsan_func_entry);
> +void __tsan_func_exit(void)
> +{
> +}
> +EXPORT_SYMBOL(__tsan_func_exit);
> +void __tsan_init(void)
> +{
> +}
> +EXPORT_SYMBOL(__tsan_init);
[...]

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl2m5gMACgkQSXnow7UH
+rjJegf/Rrq3dKwfP4Vyd25nX8MIlEeiMrDXyxhCS2tQFw7EfcgilRD8INFnob38
H/FZ9xR3ndkcpXmoq64gGCN+dEULY78jI7Zg1fpnvUcoVI+q7Hc43PWERvU3otLo
c65FZXO36WKdEg0PJ//SWfSgwQBDfUdjmJ+17YBUd/78SleSsDk9PQNm+A6yb+u5
5jsmrV1uo7vDA+B7/n8Pn06Zu8Uwi0qZn9aWQzoGwmAFrwaF7KRbvWX86p2SMr6k
Tqi7Rpp0uoJDTBFyZg3Dmnizqh81BsHEEQtI3Yjh6bKUpGdre0tyMNUVRYHpQaYX
oVHK6bV3bKlerxpvUT/SE2yOUOBGtw==
=zQTb
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
