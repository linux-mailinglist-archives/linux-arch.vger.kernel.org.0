Return-Path: <linux-arch+bounces-7797-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506EC993E56
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 07:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7D11F23FFF
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 05:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FFD13D50B;
	Tue,  8 Oct 2024 05:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EBY8Fxmr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834713D246
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365481; cv=none; b=qm8Hc2Cq/cjwbLlrB3QeDTxR2+TcHe7o8Rd8Hc+dJgahWPwpQ2g9WyqzAy5VddipPERlDHlt5zgN+dEQSR7JcNkavIJfmtfTxcfFIK+vgfWuQA4DgR+XvHlJmU3e6hf+ZYezUfERLzTbfVNufJBijb798Q6KITn+3XqlGk6YAxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365481; c=relaxed/simple;
	bh=WDw/cRG2gSxhXGHDjYT4x9DddR4Abt4s4iFvVabTMDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAcU8HUHYt3LgaSUprZL664nKZpmrrNZp0mdoSO2MadkB7gvMsGiSRmp3MS7X8Yk9x9jknfWABNjhRq4Nw18b40X78jmA1MLL1Cb0OwUzsMR3aTTHJf6WC24fUzTabZAxcfViDTQ8loKTrYcsocG26fhHvNehK4ZaYrRIt7mRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EBY8Fxmr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ba8d92af9so38901525ad.3
        for <linux-arch@vger.kernel.org>; Mon, 07 Oct 2024 22:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728365478; x=1728970278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YVWWt1mcV86CG5um5aUopa5TS6G5mg+pb0D64jrI0rI=;
        b=EBY8Fxmr9zJQlF5ZtGZX1wTNaZ5k/AmvJoWfR0BTseXn10cvgJKwDO+jS+//rXnPK5
         fMj6fV2whRiubeOrK7vemA1AcDV8/Fg18D/N5BJw1EzNiowC0/il1Rd1DOR6KLqlaLtt
         OxmEUwOXg0cdqht0AgkY8bk4ENW7WI2ebNEUxid4nE6aov5pecGmGjDZjwzoU1ZayXos
         RnUhL2MtMvw3XQLgwe5NnHHHAQU4jbpotaqJ2KN7P2BBgf9nqLxZR04NEUobUb1Vkzrf
         TkalhvTJJeKVNUPLLXyIAGQwQzteT74/nSD2KHDAadMaWckVHKc4y6/94+GjBYwO3PAe
         jLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728365478; x=1728970278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVWWt1mcV86CG5um5aUopa5TS6G5mg+pb0D64jrI0rI=;
        b=SLYuWYEC7Ao1/U2k9tw30HaGIlowGAdfYRDq24rAfq9fZ35VUE80DxUT+X9tHUhOXZ
         k0mAa82XressYTJqw1Y2tGZ+d5cgHRDOvmsect2uPWkHWJh5c+Z8egf6gPBDVmdsTmRZ
         zbs5hamm5MA6zVe5tSWtrlLRukbNHi4xJigOuUcGUVBYbdwXRb8NSY0L/9uG2idDOl9K
         DfwIpmf+73p0C0Q1q9dZg7ibIxzcWgOdNf5j8niTxzlYnTZhvLiiKJiSDVx0+Mcld0zH
         R00jSiPcBcWWMRVaE7urVIeMk0KZr3Akbbrbi4KrKtkjg60x5fUCF4nu2TIrP36yW/rk
         r2ww==
X-Forwarded-Encrypted: i=1; AJvYcCUDD8TWX9eIJHkgSL5UggGmvl7X3BUkVamxuxokxY5fMN7rm/ZegqM9BMPyLdkwzHt/8AyS6+wBpIDU@vger.kernel.org
X-Gm-Message-State: AOJu0YweMMp5b/RPuVS66KRKy15p16ZLyV59K12RX2ZVNa0faH0lU07M
	l6L2nw19xkvEnMkJ4Fq4L1DY8D0f5maV11aYVD9B8b1HMSj7VwB3Sgqma7Xp1i0=
X-Google-Smtp-Source: AGHT+IGthWcJ/4TKf5GSv621dnUUfPBgutAW7rucqDwxG39GX8eeue8mfmIeD0tAu25NcYxCwQyqlA==
X-Received: by 2002:a17:902:d4cd:b0:20b:7731:e3f8 with SMTP id d9443c01a7336-20bfe00b926mr216344355ad.26.1728365478346;
        Mon, 07 Oct 2024 22:31:18 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393a292sm48470455ad.173.2024.10.07.22.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 22:31:18 -0700 (PDT)
Date: Mon, 7 Oct 2024 22:31:14 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Zong Li <zong.li@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 16/33] riscv/shstk: If needed allocate a new shadow stack
 on clone
Message-ID: <ZwTDonkiATv999sS@debug.ba.rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
 <20241001-v5_user_cfi_series-v1-16-3ba65b6e550f@rivosinc.com>
 <CANXhq0rpwQkZ9+mZLGVUq=r4WiA8BbZ-eeTDogf3fzeEPqeeqA@mail.gmail.com>
 <ZwRvAEwFbrpq3zZq@debug.ba.rivosinc.com>
 <CANXhq0qaokjDC9hb75_dpGuyOd_ex8+q7YNe8pAg7dbTcxuLSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0qaokjDC9hb75_dpGuyOd_ex8+q7YNe8pAg7dbTcxuLSg@mail.gmail.com>

On Tue, Oct 08, 2024 at 01:16:17PM +0800, Zong Li wrote:
>On Tue, Oct 8, 2024 at 7:30 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> On Mon, Oct 07, 2024 at 04:17:47PM +0800, Zong Li wrote:
>> >On Wed, Oct 2, 2024 at 12:20 AM Deepak Gupta <debug@rivosinc.com> wrote:
>> >>
>> >> Userspace specifies CLONE_VM to share address space and spawn new thread.
>> >> `clone` allow userspace to specify a new stack for new thread. However
>> >> there is no way to specify new shadow stack base address without changing
>> >> API. This patch allocates a new shadow stack whenever CLONE_VM is given.
>> >>
>> >> In case of CLONE_VFORK, parent is suspended until child finishes and thus
>> >> can child use parent shadow stack. In case of !CLONE_VM, COW kicks in
>> >> because entire address space is copied from parent to child.
>> >>
>> >> `clone3` is extensible and can provide mechanisms using which shadow stack
>> >> as an input parameter can be provided. This is not settled yet and being
>> >> extensively discussed on mailing list. Once that's settled, this commit
>> >> will adapt to that.
>> >>
>> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> >> ---
>> >>  arch/riscv/include/asm/usercfi.h |  25 ++++++++
>>
>> ... snipped...
>>
>> >> +
>> >> +/*
>> >> + * This gets called during clone/clone3/fork. And is needed to allocate a shadow stack for
>> >> + * cases where CLONE_VM is specified and thus a different stack is specified by user. We
>> >> + * thus need a separate shadow stack too. How does separate shadow stack is specified by
>> >> + * user is still being debated. Once that's settled, remove this part of the comment.
>> >> + * This function simply returns 0 if shadow stack are not supported or if separate shadow
>> >> + * stack allocation is not needed (like in case of !CLONE_VM)
>> >> + */
>> >> +unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
>> >> +                                          const struct kernel_clone_args *args)
>> >> +{
>> >> +       unsigned long addr, size;
>> >> +
>> >> +       /* If shadow stack is not supported, return 0 */
>> >> +       if (!cpu_supports_shadow_stack())
>> >> +               return 0;
>> >> +
>> >> +       /*
>> >> +        * If shadow stack is not enabled on the new thread, skip any
>> >> +        * switch to a new shadow stack.
>> >> +        */
>> >> +       if (is_shstk_enabled(tsk))
>> >
>> >Hi Deepak,
>> >Should it be '!' is_shstk_enabled(tsk)?
>>
>> Yes it is a bug. It seems like fork without CLONE_VM or with CLONE_VFORK, it was returning
>> 0 anyways. And in the case of CLONE_VM (used by pthread), it was not doing the right thing.
>
>Hi Deepak,
>I'd like to know if I understand correctly. Could I know whether there
>might also be a risk when the user program doesn't enable the CFI and
>the kernel doesn't activate CFI. Because this flow will still try to
>allocate the shadow stack and execute the ssamowap command. Thanks

`shstk_alloc_thread_stack` is only called from `copy_thread` and  allocates and
returns non-zero (positive value) for ssp only if `CLONE_VM` is specified.
`CLONE_VM` means that address space is shared and userspace has allocated
separate stack. This flow is ensuring that newly created thread with separate
data stack gets a separate shadow stack as well.

Retruning zero value from `shstk_alloc_thread_stack` means that, no need to
allocate a shadow stack. If you look at `copy_thread` function, it simply sets
the returned ssp in newly created task's task_struct (if it was non-zero).
If returned ssp was zero, `copy_thread` doesn't do anything. Thus whatever is
current task settings are that will be copied over to new forked/cloned task.
If current task had shadow stack enabled, new task will also get it enabled at
same address (to be COWed later).

Any task get shadow stack enabled for first time using new prctls (see prctl
patches).

So only time `ssamoswap` will be exercised will be are
- User issues enabling `prctl` (it'll be issued from loader)
- fork/clone happens

In both cases, it is guarded against checks of whether cpu supports it and task
has shadow stack enabled.

Let me know if you think I missed any flow.

>
>> Most of the testing has been with busybox build (independent binaries0 driven via buildroot
>> setup. Wondering why it wasn't caught.
>>
>> Anyways, will fix it. Thanks for catching it.
>>
>> >
>> >> +               return 0;
>> >> +
>> >> +       /*

