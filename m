Return-Path: <linux-arch+bounces-13711-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA63B90745
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 13:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9CB189F307
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 11:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C2A3054C3;
	Mon, 22 Sep 2025 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OcXzLsdJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3BD76026
	for <linux-arch@vger.kernel.org>; Mon, 22 Sep 2025 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541312; cv=none; b=GnglonugctQ5RS+pZ2EhdiLm/bFIYsRWxDYUsNeDgo79oP0eHhsvx9vy13NU+oSK67n/VuCb9neERB1zOSDzhgOCHQ1aBDIF+UAbpwlMERWKDQUQXzfCTD7J3FvsdmGwrsYqL26y5MEvU9jgJdw3CtzPqa+AhQQvX00Iwb3u5/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541312; c=relaxed/simple;
	bh=SkmDfKo+eEdjnW9uMKMhb4tyiSGYMXbg6bDpRiMZguo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ip6+bHgbm75aOqarmc5FPGKlBC0AsoourkQVxIaO3iiztGKqVhQqHD0z6tn47dPXg+nThwgrT8jikaOWOoW0PMifclewL1nzsP2e9tBrF9Ym24yv+NVkpgUCyB7yIAScFlsn9BFynIS3cG3/9GLZvRVgJGRTSZDuhqSZL+60fIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OcXzLsdJ; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so1104490f8f.3
        for <linux-arch@vger.kernel.org>; Mon, 22 Sep 2025 04:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758541307; x=1759146107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZhfkZrmmENpriZJPsLNFxh8UI4vzLjIXEUlO8v8wBA=;
        b=OcXzLsdJ1YZyIxwgUJRGukEW6/uWhEpkcFwgaL2XZ5cqc0tB5LrVGRpeMHNwW0kZ3O
         tqFibgowQiMpdckc2oHMbXSvCSukp+iT7qj9Ig8uq746SuhkymQle7CzBa8JgaO6wxt1
         XAUngZMd7hvjPdHfKyT7DG5bQXJphzTnBbMgrOqN+L/j3OrDfAK7x9eKICa7q679BD96
         cdqnwL6yJRdr/IXbLIqf6M+EMLbWvIxX7RxnyiXqml/gqoUMnjte/LXsy9gxu9HcDYDw
         bN0d8nk8vD/g54TGEPR6itrIthwXA/2Z4l9wjDZjWuhKOrJvTOGY+rqyeO4ErM4FFTuw
         8aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758541307; x=1759146107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZhfkZrmmENpriZJPsLNFxh8UI4vzLjIXEUlO8v8wBA=;
        b=wwlF6P3iXi8EiLGayErRoX2wiA2COkMyvk8tWJ+MvjRmD538uTXicPRNNekcOkfUDi
         mTxDPHFtI6goEZ1f1jDAjsb01raGpGGIEMy5dbibY5mPv28cRdqYgJ/63FXkt9H5T4hG
         zkG3ebIaRKdyK99nk75JHsBlyoybhwTxx6kx+gGiOfS7WlQnwcEdlK0g1x3jIJGa5fWr
         l/McbySrW52ORm29JJy12fJqgWCq2o68EQxKN82LshHe4/b2338ZFSWPJ5AdDyOeOpqK
         2YTKZ0cTQ7N+pHaFK7n5Eee6K3NwhrJK4R4/w0NpbnPDl6ljuybgUXRUWN8yXYCL4IKS
         bpaw==
X-Forwarded-Encrypted: i=1; AJvYcCVrqQmooDzBRcdI20BpW/Vf5OFRbwizkyyM0IYnSeIjFo33PtZjyZWbl9jGmFuhGkzOejhykRBHj76R@vger.kernel.org
X-Gm-Message-State: AOJu0YxYH/a/JDoe+CX4UeI4wLFPqJ8zxv8oOOGUjRw8JeK3E5jYZJjv
	Ijmue/L0M6K1V/2e1czD2PZNbYd/uxP3DEYSrsDi1/DwbzLDKjFRHhEMmKF3w/enojw=
X-Gm-Gg: ASbGncvh0MFSJ6iYdYaCGdo5csbfr9rnDfEjqYdXzmyDKcjv/RiHzzNJmwgYN/hSzdA
	zTvfBa2rzn8SOw5MuTXsBFnXTyOmjSHcJOKmWsQK4UnWWAkx91mX56bNxyVsMD5ZeyUf+e8eBjk
	R979rYqajADcwXvFuGtO4vcGv+KtjqypIBVbsS1v+5+Hs26lisp3ObYjlAJGAYqsSL7mvxL0E8g
	nW5cTX+bqZIxTZKBHWNmmBkz1ZY7DAhJ610xqDksahRYam+02L16K2+VWFcIpEvG6v2hgLMn2WO
	2YMIbaUTxFqsJhiFAwc3BOtYaFk/IoLaA9umA2NPjQE82mzqDLq7sKtqUdD0ZPuommzZz4Fjd2X
	OqVm0/5J8NjHYdEH+/3NFvkgLB8SErUa4hXvwTkHZAHA=
X-Google-Smtp-Source: AGHT+IFSgf0/67bknpjpjI1D9ssQyqK0+H61LFm4GaoxDPRZUS53Mc3VlNw/HYi2tcLYwMO2NCcHbg==
X-Received: by 2002:a05:6000:238a:b0:3fe:34ec:2f8f with SMTP id ffacd0b85a97d-3fe34ec3351mr2639110f8f.40.1758541306596;
        Mon, 22 Sep 2025 04:41:46 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325cec0fsm141095505e9.4.2025.09.22.04.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 04:41:46 -0700 (PDT)
Message-ID: <2bf54830-ea9c-4962-a7ef-653fbed8f8c0@suse.com>
Date: Mon, 22 Sep 2025 13:41:45 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/10] scalable symbol flags with __kflagstab
To: Sid Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Giuliano Procida <gprocida@google.com>,
 =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <4e215854-59df-489b-b92d-8d2fb2edf522@suse.com>
 <CA+OvW8ZY1D3ECy2vw_Nojm1Kc8NzJHCpqNJUF0n8z3MhLAQd8A@mail.gmail.com>
 <409ddefc-24f8-465c-8872-17dc585626a6@suse.com>
 <CA+OvW8bhWK7prmyQMMJ_VYBeGMbn_mNiamHhUgYuCsnht+LFtA@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CA+OvW8bhWK7prmyQMMJ_VYBeGMbn_mNiamHhUgYuCsnht+LFtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/15/25 5:53 PM, Sid Nayyar wrote:
> On Mon, Sep 8, 2025 at 11:09 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>> This sounds reasonable to me. Do you have any numbers on hand that would
>> show the impact of extending __ksymtab?
> 
> I did performance analysis for module loading. The kflagstab
> optimizes symbol search, which accounts for less than 2% of the
> average module load time. Therefore, this change does not translate
> into any meaningful gains (or losses) in module loading performance.
> 
> On the binary size side, the on-disk size for vmlinux is somewhat
> inflated due to extra entries in .symtab and .strtab. Since these
> sections are not part of the final Image, the only increase in the
> in-memory size of the kernel is for the kflagstab itself. This new
> table occupies 1 byte for each symbol in the ksymtab.

This is useful information. However, I was specifically interested in
the impact of having the new flags field present as part of __ksymtab
(kernel_symbol), compared to keeping it in a separate section. Sorry for
not being clear.

I ran a small test to get a better understanding of the different sizes.
I used v6.17-rc6 together with the openSUSE x86_64 config [1], which is
fairly large. The resulting vmlinux.bin (no debuginfo) had an on-disk
size of 58 MiB, and included 5937 + 6589 (GPL-only) exported symbols.

The following table summarizes my measurements and calculations
regarding the sizes of all sections related to exported symbols:

                      |  HAVE_ARCH_PREL32_RELOCATIONS  | !HAVE_ARCH_PREL32_RELOCATIONS
 Section              | Base [B] | Ext. [B] | Sep. [B] | Base [B] | Ext. [B] | Sep. [B]
----------------------------------------------------------------------------------------
 __ksymtab            |    71244 |   200416 |   150312 |   142488 |   400832 |   300624
 __ksymtab_gpl        |    79068 |       NA |       NA |   158136 |       NA |       NA
 __kcrctab            |    23748 |    50104 |    50104 |    23748 |    50104 |    50104
 __kcrctab_gpl        |    26356 |       NA |       NA |    26356 |       NA |       NA
 __ksymtab_strings    |   253628 |   253628 |   253628 |   253628 |   253628 |   253628
 __kflagstab          |       NA |       NA |    12526 |       NA |       NA |    12526
----------------------------------------------------------------------------------------
 Total                |   454044 |   504148 |   466570 |   604356 |   704564 |   616882
 Increase to base [%] |       NA |     11.0 |      2.8 |       NA |     16.6 |      2.1

The column "HAVE_ARCH_PREL32_RELOCATIONS -> Base" contains the numbers
that I measured. The rest of the values are calculated. The "Ext."
column represents the variant of extending __ksymtab, and the "Sep."
column represents the variant of having a separate __kflagstab. With
HAVE_ARCH_PREL32_RELOCATIONS, each kernel_symbol is 12 B in size and is
extended to 16 B. With !HAVE_ARCH_PREL32_RELOCATIONS, it is 24 B,
extended to 32 B. Note that this does not include the metadata needed to
relocate __ksymtab*, which is freed after the initial processing.

The base export data in this case totals 0.43 MiB. About 50% is used for
storing the names of exported symbols.

Adding __kflagstab as a separate section has a negligible impact, as
expected. When extending __ksymtab (kernel_symbol) instead, the worst
case with !HAVE_ARCH_PREL32_RELOCATIONS increases the export data size
by 16.6%.

Based on the above, I think introducing __kflagstab makes senses, as the
added complexity is minimal, although I feel we could probably also get
away with extending kernel_symbol.

> 
>>> The Android Common Kernel source is compiled into what we call
>>> GKI (Generic Kernel Image), which consists of a kernel and a
>>> number of modules. We maintain a stable interface (based on CRCs and
>>> types) between the GKI components and vendor-specific modules
>>> (compiled by device manufacturers, e.g., for hardware-specific
>>> drivers) for the lifetime of a given GKI version.
>>>
>>> This interface is intentionally restricted to the minimal set of
>>> symbols required by the union of all vendor modules; our partners
>>> declare their requirements in symbol lists. Any additions to these
>>> lists are reviewed to ensure kernel internals are not overly exposed.
>>> For example, we restrict drivers from having the ability to open and
>>> read arbitrary files. This ABI boundary also allows us to evolve
>>> internal kernel types that are not exposed to vendor modules, for
>>> example, when a security fix requires a type to change.
>>>
>>> The mechanism we use for this is CONFIG_TRIM_UNUSED_KSYMS and
>>> CONFIG_UNUSED_KSYMS_WHITELIST. This results in a ksymtab
>>> containing two kinds of exported symbols: those explicitly required
>>> by vendors ("vendor-listed") and those only required by GKI modules
>>> ("GKI use only").
>>>
>>> On top of this, we have implemented symbol import protection
>>> (covered in patches 9/10 and 10/10). This feature prevents vendor
>>> modules from using symbols that are not on the vendor-listed
>>> whitelist. It is built on top of CONFIG_MODULE_SIG. GKI modules are
>>> signed with a specific key, while vendor modules are unsigned and thus
>>> treated as untrusted. This distinction allows signed GKI modules to
>>> use any symbol in the ksymtab, while unsigned vendor modules can only
>>> access the declared subset. This provides a significant layer of
>>> defense and security against potentially exploitable vendor module
>>> code.
>>
>> If I understand correctly, this is similar to the recently introduced
>> EXPORT_SYMBOL_FOR_MODULES() macro, but with a coarser boundary.
>>
>> I think that if the goal is to control the kABI scope and limit the use
>> of certain symbols only to GKI modules, then having the protection
>> depend on whether the module is signed is somewhat odd. It doesn't give
>> me much confidence if vendor modules are unsigned in the Android
>> ecosystem. I would expect that you want to improve this in the long
>> term.
> 
> GKI modules are the only modules built in the same Kbuild as the
> kernel image, which Google builds and provides to partners. In
> contrast, vendor modules are built and packaged entirely by partners.
> 
> Google signs GKI modules with ephemeral keys. Since partners do
> not have these keys, vendor modules are treated as unsigned by
> the kernel.
> 
> To ensure the authenticity of these unsigned modules, partners
> package them into a separate image that becomes one of the boot
> partitions. This entire image is signed, and its signature is
> verified by the bootloader at boot time.
> 
>> It would then make more sense to me if the protection was determined by
>> whether the module is in-tree (the "intree" flag in modinfo) or,
>> alternatively, if it is signed by a built-in trusted key. I feel this
>> way the feature could be potentially useful for other distributions that
>> care about the kABI scope and have ecosystems where vendor modules are
>> properly signed with some key. However, I'm not sure if this would still
>> work in your case.
> 
> Partners can produce both in-tree and out-of-tree modules. We do not
> trust either type regarding symbol exposure, as there is no way to know
> exactly what sources were used. Furthermore, symbols exported via
> EXPORT_SYMBOL_FOR_MODULES can be accessed by any vendor module that
> mimics the GKI module name.
> 
> Therefore, neither the in-tree flag nor the EXPORT_SYMBOL_FOR_MODULES
> mechanism provides a strong enough guarantee for the Android kernel to
> identify GKI modules.
> 
> Only module signatures are sufficient to allow a module to access the
> full set of exported symbols.  Unsigned vendor modules may only access
> the symbol subset declared ahead of time by partners.

This seems to answer why the in-tree flag is not sufficient for you.
However, I also suggested an alternative that the symbol protection
could be determined by whether the module is signed by a key from the
.builtin_trusted_keys keyring, as opposed to being signed by another key
reachable from the .secondary_trusted_keys keyring or being completely
unsigned.

Distributions can require that external modules be signed and allow
additional keys to be added as Machine Owner Keys, which can be made
reachable from .secondary_trusted_keys. Nonetheless, such distributions
might be still interested in limiting the number of symbols that such
external modules can use.

I think this option is worth considering, as it could potentially make
this symbol protection useful for other distributions as well.

> 
> In case such symbol protection is not useful for the Linux community, I
> am happy to keep this as an Android-specific feature.  However, I would
> urge you to at least accept the kflagstab, as it allows us (and
> potentially other Linux distributions) to easily introduce additional
> flags for symbols. It is also a simplification/clean-up of the module
> loader code.

I'm personally ok with adding the kflagstab support. I think it
introduces minimal complexity and, as you point out, simplifies certain
aspects. Additionally, if we add it, I believe that adding the proposed
symbol protection is simple enough to be included as well, at least from
my perspective.

[1] https://github.com/openSUSE/kernel-source/blob/307f149d9100a0e229eb94cbb997ae61187995c3/config/x86_64/default

-- 
Thanks,
Petr

