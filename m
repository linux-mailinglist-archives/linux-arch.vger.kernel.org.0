Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B3A7B098A
	for <lists+linux-arch@lfdr.de>; Wed, 27 Sep 2023 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjI0QDm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Sep 2023 12:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjI0QDY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Sep 2023 12:03:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B2A10E0
        for <linux-arch@vger.kernel.org>; Wed, 27 Sep 2023 09:03:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c60cec8041so54244875ad.3
        for <linux-arch@vger.kernel.org>; Wed, 27 Sep 2023 09:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695830588; x=1696435388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cc32aBSxiKmB7YJYiVYNyRkEBllulbgFY+PbuERINks=;
        b=ABmtJMNyGm2g+XCX436Xz/kj9gWN4T5A/ws3WsfsEJyoKgGmFCzrRrtnOovg5Fv4H+
         ljOh+pq90hESatFWH+BeD76IK6s7R/uydMKDDxUgMKvnfAbIHMr7p3eeETMi+lYNMo9L
         ldtZJPyireJ1upycmQsYIJQpeoVk4o8ePWoZb+Bl6h04wdLBcF/316EMubQf07Gw0vyl
         gC1nKKdHZR2AnbIZ/oW6VFtKOeeEElyoxCm4InpZpBQRdhrECxGs9zds4RcKLgTxME2O
         qS0IcOl4szdaetF1CLiDi9Iv4GZ2gNmDFx6rmEHDNgEQcZypZLTJ6IvZ+OmtgdRSfnn4
         Hi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695830588; x=1696435388;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cc32aBSxiKmB7YJYiVYNyRkEBllulbgFY+PbuERINks=;
        b=mBjyQ6xSFRulxfNO/1TS60guPYBsfOJV4hw636GjdRU2S4zZp8e5xotNEhfkOODWuM
         1GeTD3mHo+l9lQjsyRy8lS4u1XnMucmVeeZjFZbSbbsvHS4SC8AcKI2h6ZXszblAQ6Gc
         n78bl60fArd7DbTd06j4MuzPFZftzeevqzKDHwDSpqJcX2VH8O9A4HBGM/vU/l9+zi6k
         nfy1D1Hv2rsd7dO/g19UAccwP9U0ujcVZtxfSXU3qJ39kIxZmdzrsdgjFIGUQ8AkUwI/
         fnDjEMMlNlpmqaJy6Z/UFb/ZOQaj5mt1tpctzsERRJnW7eT3Ui8miQ8xtUILoD+64YhX
         Mgtg==
X-Gm-Message-State: AOJu0Yy3qWtphAvo0gcBSBJOIvwrM91dEhKCP3AYpCpb8H3Ctq7oaugK
        7Rn0HaOeSS4Jky4qhLEUwPsxfA==
X-Google-Smtp-Source: AGHT+IHxY4DW2OVHGZCmyyi4u1VB9W8yCdtBLbEwI6vaIqaWlrij8p9kxEZXh5NCY69eQYN3+gKd+Q==
X-Received: by 2002:a17:902:b414:b0:1c3:52ed:18f9 with SMTP id x20-20020a170902b41400b001c352ed18f9mr1953496plr.62.1695830587598;
        Wed, 27 Sep 2023 09:03:07 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c1:6eb0:6d4f:92fe:5e4e:27d3? ([2804:1b3:a7c1:6eb0:6d4f:92fe:5e4e:27d3])
        by smtp.gmail.com with ESMTPSA id az11-20020a170902a58b00b001c5bcc9d916sm13274132plb.176.2023.09.27.09.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 09:03:06 -0700 (PDT)
Message-ID: <97eb2099-23c2-4921-89ac-9523226ad221@linaro.org>
Date:   Wed, 27 Sep 2023 13:03:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector,
 entries
Content-Language: en-US
To:     Peter Bergner <bergner@linux.ibm.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        GNU C Library <libc-alpha@sourceware.org>
References: <fd879f60-3f0b-48d1-bfa1-6d337768207e@linux.ibm.com>
From:   Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <fd879f60-3f0b-48d1-bfa1-6d337768207e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 26/09/23 19:02, Peter Bergner wrote:
> The powerpc toolchain keeps a copy of the HWCAP bit masks in our TCB for fast
> access by our __builtin_cpu_supports built-in function.  The TCB space for
> the HWCAP entries - which are created in pairs - is an ABI extension, so
> waiting to create the space for HWCAP3 and HWCAP4 until we need them is
> problematical, given distro unwillingness to apply ABI modifying patches
> to distro point releases.  Define AT_HWCAP3 and AT_HWCAP4 in the generic
> uapi header so they can be used in GLIBC to reserve space in the powerpc
> TCB for their future use.

This is different than previously exported auxv, where each AT_* constant
would have a auxv entry. On glibc it would require changing _dl_parse_auxv
to iterate over the auxv_values to find AT_HWCAP3/AT_HWCAP4 (not ideal, 
but doable).

Wouldn't be better to always export it on fs/binfmt_elf.c, along with all 
the machinery to setup it (ELF_HWCAP3, etc), along with proper documentation?

> 
> I scanned both the Linux and GLIBC source codes looking for unused AT_*
> values and 29 and 30 did not seem to be used, so they are what I went
> with.  If anyone sees a problem with using those specific values, I'm
> amenable to using other values, just let me know what would be better.
> 
> Peter
> 
> 
> Signed-off-by: Peter Bergner <bergner@linux.ibm.com>
> ---
>  include/uapi/linux/auxvec.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
> index 6991c4b8ab18..cc61cb9b3e9a 100644
> --- a/include/uapi/linux/auxvec.h
> +++ b/include/uapi/linux/auxvec.h
> @@ -32,6 +32,8 @@
>  #define AT_HWCAP2 26	/* extension of AT_HWCAP */
>  #define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
>  #define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
> +#define AT_HWCAP3 29	/* extension of AT_HWCAP */
> +#define AT_HWCAP4 30	/* extension of AT_HWCAP */
>  
>  #define AT_EXECFN  31	/* filename of program */
>  
