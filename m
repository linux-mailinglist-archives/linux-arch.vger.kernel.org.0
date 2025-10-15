Return-Path: <linux-arch+bounces-14153-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D622BE0B79
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 22:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D4D1A22F65
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 20:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2B12D8390;
	Wed, 15 Oct 2025 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="DoRvfCr6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713BF2D061B
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760561825; cv=none; b=cE80KUfGebwDRqBBv6rFyj/gCQa6La/r1H4hzSMe7CfWfM+L/FwnH0JLnDtzIkVPVVReOSafpnSxvX9wY2U/Tx/yTZSREOicDvI6KmydjA5dNnHj1AvD6d/eZoz6M6MUAs9TfMLatF7AVSi9PO8vFg1ta2ksX8vVsL54q6dvub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760561825; c=relaxed/simple;
	bh=A78iN+rgxSiV6lxKErBK8A+jZK/Hr9J1s3+XCMErbAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f89uELWsrdDVVq2UkUMQZK9LpqzumW7HylM+6eKokajMKTpTrF3yahKXAUghOShTa8TDOB+4E4K62Zia8SluioHxUwt1rUpe4uYj3lwEjVG45nx7vlKM6aTr1KIQJk9imLklKTg3ihByqVro1JrwQ/5DyFiyvsS7kOB9788TlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=DoRvfCr6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso78664b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760561823; x=1761166623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtJ7DaV1gwJQgtXjwIR5eEbDMXGgeP8Qy25oJGnYRdI=;
        b=DoRvfCr6TdQyvjdaCJZZIuijkoGey/zl2c+DrYqXrATTbR6IvXdyUynZFVqU8hVECu
         8dD8j7YihRCJV1Xg+pa5bQuji0MIjhlpnTv1wIrKfWCYhQt6kmlT4pW6IwmYkh+tkwU9
         NydG9snL0RHqCyKrYRD0KzckjRRiMkWppi3G3jsp0faghrAmhQcPm0txLTviPk13cElc
         R8oxIkiv3b+450aOXvVGAupTzRGiarkj3kxVxVd1Aacp9j+QXwRkPRZTGNXzAsSf6nYU
         tl+F7EfR4r1O1Xi4SCZO4wD2XXNtreSP3y6SCCc9eIH8hc3QgyG5don5peS7SqbYUam/
         yUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760561823; x=1761166623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtJ7DaV1gwJQgtXjwIR5eEbDMXGgeP8Qy25oJGnYRdI=;
        b=u1nmD7ytT8u6ufuB2tVPJVAioVHJ6Mgw5XRVm6ux9dRqU0XFiin4075Swv3YUMtUJx
         b5eZ+RVSU6eYgBwXqP3/cx7iAZ3OLHI9SWbcVmDg2Paj0R/bixsTTS/lMvhcPJW2CLqA
         +csryvOgM3oqMUq3ruevhl8ns4fziDfMGaDOl8f5QlznGQJoUeA7+YnJJ4cdhHlmlzMx
         /yxq01PEvOc1xGYiCPlfpoD+EC5rlAd+a6WjRJk2UgQvQ8wD5NCAZIued1GF6NOlUfap
         BQFU8DFNNUU1pwokQGtPv1P8GmDkrg65nBNZeFH6bTp3MOWP6YBp4/UPzgZqalrbpXEY
         jJtg==
X-Forwarded-Encrypted: i=1; AJvYcCUV2j5UEsq4NWWelvT5jDsbdsW/GxI0ixda9FIzkkcXi+5gLuTvUG+9FHK6G8YDbp2hr65ZnT4y/mZ+@vger.kernel.org
X-Gm-Message-State: AOJu0YwUvL5zAYPTGDOQ52IgHRvCGrcMjuwcyE3VXzgtrh/qBG38/3Ud
	gtw53/UIEUQLdjnTQXPd7nfIto9vM4c4OQn691nuhoQ9Eybf+fZ6/YqXDHVLJLL0tl8=
X-Gm-Gg: ASbGncvy/FNUW8mctptUhQC357uTRaFztIcaic5Z1DQTdN2vvtaL9z6Xuo93PydX9fH
	+qwl9lHiDhuVx4JdjN6BSd01kvpLHgCJ7/nMcYBIxi0X/AKJTQulh/Qfxx0xm95pk4ahqvANthf
	WjD2gq+B6LwabP0v+3QSRdUc53DqnNEM4MpoXWA0NCFerWF8Qlb68Fmvr51ACSV6J5Or8S1lXYs
	VvKMGQ8F4Vb+T6yJmr7NsOb0Owmi5wBHRKlpc0otYYVjH2w1eH6iNJwiFZ3AYPSUJt4d0bfIyNI
	fRRFQvRUV+gFI1ad6RUEzrTMffbTh90H9R0/rg9DbC5YfnooDNMGsMo6NMc3bm2YmzN9DUdBz5a
	DQ85KWFm7PgkWHGrLFg79RG1IYAqRstLbWVTjF9cASPYRHI8P8bfywIpt94ABhQ==
X-Google-Smtp-Source: AGHT+IGB+5aNaGhvYx/i7SuLRZMzUGb9z0qxzWuFI5LtrYeUM1k/B64dlkgzbMPNLYbYv0YwsW+Slg==
X-Received: by 2002:a05:6a21:3396:b0:334:8f45:8e99 with SMTP id adf61e73a8af0-3348f459868mr3796560637.35.1760561822048;
        Wed, 15 Oct 2025 13:57:02 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b06075fsm20255047b3a.17.2025.10.15.13.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:57:01 -0700 (PDT)
Date: Wed, 15 Oct 2025 13:56:56 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Charles Mirabile <cmirabil@redhat.com>
Cc: Liam.Howlett@oracle.com, a.hindborg@kernel.org,
	akpm@linux-foundation.org, alex.gaynor@gmail.com,
	alexghiti@rivosinc.com, aliceryhl@google.com,
	alistair.francis@wdc.com, andybnac@gmail.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, atishp@rivosinc.com, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, bp@alien8.de, brauner@kernel.org,
	broonie@kernel.org, charlie@rivosinc.com, cleger@rivosinc.com,
	conor+dt@kernel.org, conor@kernel.org, corbet@lwn.net,
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
	ebiederm@xmission.com, evan@rivosinc.com, gary@garyguo.net,
	hpa@zytor.com, jannh@google.com, jim.shu@sifive.com,
	kees@kernel.org, kito.cheng@sifive.com, krzk+dt@kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, lorenzo.stoakes@oracle.com,
	lossin@kernel.org, mingo@redhat.com, ojeda@kernel.org,
	oleg@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
	peterz@infradead.org, richard.henderson@linaro.org,
	rick.p.edgecombe@intel.com, robh@kernel.org,
	rust-for-linux@vger.kernel.org, samitolvanen@google.com,
	shuah@kernel.org, tglx@linutronix.de, tmgross@umich.edu,
	vbabka@suse.cz, x86@kernel.org
Subject: Re: [PATCH v20 24/28] arch/riscv: dual vdso creation logic and
 select vdso based on hw
Message-ID: <aPAKmCwDeXXvU7VD@debug.ba.rivosinc.com>
References: <20251013-v5_user_cfi_series-v20-24-b9de4be9912e@rivosinc.com>
 <20251015203611.2572538-1-cmirabil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251015203611.2572538-1-cmirabil@redhat.com>

Hi Charles,


On Wed, Oct 15, 2025 at 04:36:11PM -0400, Charles Mirabile wrote:
>Hi Deepak -
>
>On Mon, Oct 13, 2025 at 02:56:16PM -0700, Deepak Gupta wrote:
>> Shadow stack instructions are taken from zimop (mandated on RVA23).
>> Any hardware prior to RVA23 profile will fault on shado stack instruction.
>> Any userspace with shadow stack instruction in it will fault on such
>> hardware. Thus such userspace can't be brought onto such a hardware.
>>
>> It's not known how userspace will respond to such binary fragmentation.
>> However in order to keep kernel portable across such different hardware,
>> `arch/riscv/kernel/vdso_cfi` is created which has logic (Makefile) to
>> compile `arch/riscv/kernel/vdso` sources with cfi flags and then changes
>> in `arch/riscv/kernel/vdso.c` for selecting appropriate vdso depending
>> on whether underlying hardware(cpu) implements zimop extension. Offset
>> of vdso symbols will change due to having two different vdso binaries,
>> there is added logic to include new generated vdso offset header and
>> dynamically select offset (like for rt_sigreturn).
>
>This looks great. As kernel test robot highlighted, the code doesn't build
>when the config is off, but I was able to fix it with the attached patch.

Yes sorry about that. Locally include/generated had both files and that's how
I missed it.

>
>Assuming that these changes or equivalent are folded in, you have my:
>

Yes v21 changes are equivalent to what you proposed.

>Acked-by: Charles Mirabile <cmirabil@redhat.com>

If I send another version due to some other issue, I'll collect your tag.

Else
Paul,

Can you apply the tag when you take it in.

-Deepak

>
>As merely a user whose previous concerns have been addressed, I am not
>sure what that is worth, but I appreciate your effort on this.

Thanks.

>
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/Makefile                        |  3 +++
>>  arch/riscv/include/asm/vdso.h              |  7 ++++++-
>>  arch/riscv/kernel/Makefile                 |  1 +
>>  arch/riscv/kernel/vdso.c                   |  7 +++++++
>>  arch/riscv/kernel/vdso/Makefile            | 29 ++++++++++++++++++++---------
>>  arch/riscv/kernel/vdso/gen_vdso_offsets.sh |  4 +++-
>>  arch/riscv/kernel/vdso_cfi/Makefile        | 25 +++++++++++++++++++++++++
>>  arch/riscv/kernel/vdso_cfi/vdso-cfi.S      | 11 +++++++++++
>>  8 files changed, 76 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>> index f60c2de0ca08..b74b63da16a7 100644
>> --- a/arch/riscv/Makefile
>> +++ b/arch/riscv/Makefile
>> @@ -176,6 +176,8 @@ ifeq ($(CONFIG_MMU),y)
>>  prepare: vdso_prepare
>>  vdso_prepare: prepare0
>>  	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
>> +	$(if $(CONFIG_RISCV_USER_CFI),$(Q)$(MAKE) \
>> +		$(build)=arch/riscv/kernel/vdso_cfi include/generated/vdso-cfi-offsets.h)
>>  	$(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
>>  		$(build)=arch/riscv/kernel/compat_vdso include/generated/compat_vdso-offsets.h)
>>
>> @@ -183,6 +185,7 @@ endif
>>  endif
>>
>>  vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
>> +vdso-install-$(CONFIG_RISCV_USER_CFI)	+= arch/riscv/kernel/vdso_cfi/vdso-cfi.so.dbg
>>  vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
>>
>>  BOOT_TARGETS := Image Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst Image.xz loader loader.bin xipImage vmlinuz.efi
>> diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
>> index f80357fe24d1..3fc8f72b8bfb 100644
>> --- a/arch/riscv/include/asm/vdso.h
>> +++ b/arch/riscv/include/asm/vdso.h
>> @@ -18,9 +18,13 @@
>>
>>  #ifndef __ASSEMBLER__
>>  #include <generated/vdso-offsets.h>
>> +#include <generated/vdso-cfi-offsets.h>
>>
>>  #define VDSO_SYMBOL(base, name)							\
>> -	(void __user *)((unsigned long)(base) + __vdso_##name##_offset)
>> +	((IS_ENABLED(CONFIG_RISCV_USER_CFI) &&					\
>> +	  riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP)) ?			\
>> +	  (void __user *)((unsigned long)(base) + __vdso_##name##_cfi_offset) :	\
>> +	  (void __user *)((unsigned long)(base) + __vdso_##name##_offset))
>>
>>  #ifdef CONFIG_COMPAT
>>  #include <generated/compat_vdso-offsets.h>
>> @@ -33,6 +37,7 @@ extern char compat_vdso_start[], compat_vdso_end[];
>>  #endif /* CONFIG_COMPAT */
>>
>>  extern char vdso_start[], vdso_end[];
>> +extern char vdso_cfi_start[], vdso_cfi_end[];
>>
>>  #endif /* !__ASSEMBLER__ */
>>
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index 2d0e0dcedbd3..9026400cba10 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -72,6 +72,7 @@ obj-y	+= vendor_extensions/
>>  obj-y	+= probes/
>>  obj-y	+= tests/
>>  obj-$(CONFIG_MMU) += vdso.o vdso/
>> +obj-$(CONFIG_RISCV_USER_CFI) += vdso_cfi/
>>
>>  obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
>>  obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
>> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
>> index 3a8e038b10a2..bf080e519101 100644
>> --- a/arch/riscv/kernel/vdso.c
>> +++ b/arch/riscv/kernel/vdso.c
>> @@ -98,6 +98,13 @@ static struct __vdso_info compat_vdso_info __ro_after_init = {
>>
>>  static int __init vdso_init(void)
>>  {
>> +	/* Hart implements zimop, expose cfi compiled vdso */
>> +	if (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
>> +		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP)) {
>> +		vdso_info.vdso_code_start = vdso_cfi_start;
>> +		vdso_info.vdso_code_end = vdso_cfi_end;
>> +	}
>> +
>>  	__vdso_init(&vdso_info);
>>  #ifdef CONFIG_COMPAT
>>  	__vdso_init(&compat_vdso_info);
>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
>> index 272f1d837a80..a842dc034571 100644
>> --- a/arch/riscv/kernel/vdso/Makefile
>> +++ b/arch/riscv/kernel/vdso/Makefile
>> @@ -20,6 +20,10 @@ endif
>>  ifdef VDSO_CFI_BUILD
>>  CFI_MARCH = _zicfilp_zicfiss
>>  CFI_FULL = -fcf-protection=full
>> +CFI_SUFFIX = -cfi
>> +OFFSET_SUFFIX = _cfi
>> +ccflags-y += -DVDSO_CFI=1
>> +asflags-y += -DVDSO_CFI=1
>>  endif
>>
>>  # Files to link into the vdso
>> @@ -48,13 +52,20 @@ endif
>>  CFLAGS_hwprobe.o += -fPIC
>>
>>  # Build rules
>> -targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds
>> +vdso_offsets := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),)-offsets.h
>> +vdso_o := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).o
>> +vdso_so := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).so
>> +vdso_so_dbg := vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).so.dbg
>> +vdso_lds := vdso.lds
>> +
>> +targets := $(obj-vdso) $(vdso_so) $(vdso_so_dbg) $(vdso_lds)
>> +
>>  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>>
>> -obj-y += vdso.o
>> -CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
>> +obj-y += vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).o
>> +CPPFLAGS_$(vdso_lds) += -P -C -U$(ARCH)
>>  ifneq ($(filter vgettimeofday, $(vdso-syms)),)
>> -CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
>> +CPPFLAGS_$(vdso_lds) += -DHAS_VGETTIMEOFDAY
>>  endif
>>
>>  # Disable -pg to prevent insert call site
>> @@ -63,12 +74,12 @@ CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
>>  CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
>>
>>  # Force dependency
>> -$(obj)/vdso.o: $(obj)/vdso.so
>> +$(obj)/$(vdso_o): $(obj)/$(vdso_so)
>>
>>  # link rule for the .so file, .lds has to be first
>> -$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
>> +$(obj)/$(vdso_so_dbg): $(obj)/$(vdso_lds) $(obj-vdso) FORCE
>>  	$(call if_changed,vdsold_and_check)
>> -LDFLAGS_vdso.so.dbg = -shared -soname=linux-vdso.so.1 \
>> +LDFLAGS_$(vdso_so_dbg) = -shared -soname=linux-vdso.so.1 \
>>  	--build-id=sha1 --eh-frame-hdr
>>
>>  # strip rule for the .so file
>> @@ -79,9 +90,9 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
>>  # Generate VDSO offsets using helper script
>>  gen-vdsosym := $(src)/gen_vdso_offsets.sh
>>  quiet_cmd_vdsosym = VDSOSYM $@
>> -	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
>> +	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) $(OFFSET_SUFFIX) | LC_ALL=C sort > $@
>>
>> -include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
>> +include/generated/$(vdso_offsets): $(obj)/$(vdso_so_dbg) FORCE
>>  	$(call if_changed,vdsosym)
>>
>>  # actual build commands
>> diff --git a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
>> index c2e5613f3495..bd5d5afaaa14 100755
>> --- a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
>> +++ b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
>> @@ -2,4 +2,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>
>>  LC_ALL=C
>> -sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define \2_offset\t0x\1/p'
>> +SUFFIX=${1:-""}
>> +sed -n -e \
>> +'s/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define \2'$SUFFIX'_offset\t0x\1/p'
>> diff --git a/arch/riscv/kernel/vdso_cfi/Makefile b/arch/riscv/kernel/vdso_cfi/Makefile
>> new file mode 100644
>> index 000000000000..8ebd190782b0
>> --- /dev/null
>> +++ b/arch/riscv/kernel/vdso_cfi/Makefile
>> @@ -0,0 +1,25 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +# RISC-V VDSO CFI Makefile
>> +# This Makefile builds the VDSO with CFI support when CONFIG_RISCV_USER_CFI is enabled
>> +
>> +# setting VDSO_CFI_BUILD triggers build for vdso differently
>> +VDSO_CFI_BUILD := 1
>> +
>> +# Set the source directory to the main vdso directory
>> +src := $(srctree)/arch/riscv/kernel/vdso
>> +
>> +# Copy all .S and .c files from vdso directory to vdso_cfi object build directory
>> +vdso_c_sources := $(wildcard $(src)/*.c)
>> +vdso_S_sources := $(wildcard $(src)/*.S)
>> +vdso_c_objects := $(addprefix $(obj)/, $(notdir $(vdso_c_sources)))
>> +vdso_S_objects := $(addprefix $(obj)/, $(notdir $(vdso_S_sources)))
>> +
>> +$(vdso_S_objects): $(obj)/%.S: $(src)/%.S
>> +	$(Q)cp $< $@
>> +
>> +$(vdso_c_objects): $(obj)/%.c: $(src)/%.c
>> +	$(Q)cp $< $@
>> +
>> +# Include the main VDSO Makefile which contains all the build rules and sources
>> +# The VDSO_CFI_BUILD variable will be passed to it to enable CFI compilation
>> +include $(src)/Makefile
>> diff --git a/arch/riscv/kernel/vdso_cfi/vdso-cfi.S b/arch/riscv/kernel/vdso_cfi/vdso-cfi.S
>> new file mode 100644
>> index 000000000000..d426f6accb35
>> --- /dev/null
>> +++ b/arch/riscv/kernel/vdso_cfi/vdso-cfi.S
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright 2025 Rivos, Inc
>> + */
>> +
>> +#define	vdso_start	vdso_cfi_start
>> +#define	vdso_end	vdso_cfi_end
>> +
>> +#define __VDSO_PATH "arch/riscv/kernel/vdso_cfi/vdso-cfi.so"
>> +
>> +#include "../vdso/vdso.S"
>>
>> --
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>---
>diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
>index 3fc8f72b8bfb..9cfbb390270f 100644
>--- a/arch/riscv/include/asm/vdso.h
>+++ b/arch/riscv/include/asm/vdso.h
>@@ -18,13 +18,21 @@
>
> #ifndef __ASSEMBLER__
> #include <generated/vdso-offsets.h>
>+#if IS_ENABLED(CONFIG_RISCV_USER_CFI)
>+
> #include <generated/vdso-cfi-offsets.h>
>
> #define VDSO_SYMBOL(base, name)							\
>-	((IS_ENABLED(CONFIG_RISCV_USER_CFI) &&					\
>-	  riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP)) ?			\
>-	  (void __user *)((unsigned long)(base) + __vdso_##name##_cfi_offset) :	\
>-	  (void __user *)((unsigned long)(base) + __vdso_##name##_offset))
>+	(riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP)) ?			\
>+	 (void __user *)((unsigned long)(base) + __vdso_##name##_cfi_offset) :	\
>+	 (void __user *)((unsigned long)(base) + __vdso_##name##_offset)
>+
>+#else /* !CONFIG_RISCV_USER_CFI */
>+
>+#define VDSO_SYMBOL(base, name)							\
>+	(void __user *)((unsigned long)(base) + __vdso_##name##_offset)
>+
>+#endif /* CONFIG_RISCV_USER_CFI */
>
> #ifdef CONFIG_COMPAT
> #include <generated/compat_vdso-offsets.h>
>

