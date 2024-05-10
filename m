Return-Path: <linux-arch+bounces-4296-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7F48C2B2B
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 22:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAA11C2173E
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 20:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8E9225CB;
	Fri, 10 May 2024 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O8F9Z7lJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E3FC0B
	for <linux-arch@vger.kernel.org>; Fri, 10 May 2024 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373043; cv=none; b=ZlLfcIs7eN7p/qopO9jak12Af9T3GqE67HYrXlOlQkfgk9qTnHy3fd1LVJjkIc08y0Wg+aZai6dRvovTW2YRmpjcLxIJoCClach6cWxcheSIKe/gbXpyK0/WUW2/DuvXqg7LGjObXhnxYIKUi1YOlA9+cErZF5PU+otopAkzxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373043; c=relaxed/simple;
	bh=uwl1r0wrzQZCmCidHq5JuR1AW/H9uVs/PIUpQcndgSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecZNwIbQATv3NqSiHRfbcW0RwYBcVbjBJu8um51lWplV0soDkzgG1C38WGXsasK9xnBCr2Gm0/jO1s3ZquHqt4eW6A50N7AvZdrgAXLg/PrdHjQ8DGTelxgOziIirIx80m83UJCXNa+cmxJ/RJ8Gah6yH87nBjqeNIiZrnRf3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O8F9Z7lJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ecddf96313so21384625ad.2
        for <linux-arch@vger.kernel.org>; Fri, 10 May 2024 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715373040; x=1715977840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f6+vAbiClRDiC4uIvdtPo+0v0pdzSTB+/qaSHejfRyI=;
        b=O8F9Z7lJPtyJocVY0td3s5IMZZVbsa7MSr8BjngoMRdUnxNwfPTCSotm7WbOaPUJWX
         qNT8jkdSCHgIf8JEbeIZZfMcVzIH3wM0z+rCk2H7NFulWx6mn/e98ERJnNSKRqZ6Bq02
         6/CERH+tIG4avhx61qfRdk8mGOgU4YXmrZwAWk9gwiDuy/SIGfSB0jQFFl1lj5ibM6Au
         tFACBQBREaP5I2cz+eNnUtk0xE/8W3F/HQqIv3SSxP211NV48EgNJ3FSOCPwXyRWd/9Z
         ji9NJ7IKb4X2ucoAvQN9ntzz6VercbMmhhuuMpaXUkxhdMRzBHfS9dlGP5fiWhJuhY+k
         0eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715373040; x=1715977840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6+vAbiClRDiC4uIvdtPo+0v0pdzSTB+/qaSHejfRyI=;
        b=C3f99gdznHRmBEfRw45zQyLy4atwH+9/CWGjB1BNhvKqTpnlsXAGIJPuN/W7drsdan
         cnjxYEyDCOWeL+Qdar18TCpJ6oEjNl6ayzdFgN+vMJxRYg1LBdVXI4yDZFuDh6vdPfKw
         qGiml+Ii9AxkuqZE6pNY6DKoOtUTAAoV0+UNle5uqbmnoHfXGS1lflJe7y7b3x/mFB2F
         8uzXah7L8tSXm4VJ2Lap00s++VHj3J+PxypCRk5xHbRGMNs46T9OT86FnhR3n9upFbnm
         MtY1y0x0o5taCBKMMZMgfxvWfNxvYY1O09yGUvEXWkk5z89KAaZLw/2Bhc1yMDbiD4jZ
         5CHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSTiDo60eLvNMcX0XUlRxqNvtH4yfw+QvVeOJ3BhtRuF4PiLmoz0VLKqkeGuUoH2/CKWN/dW/5GuuwSPyE/8bGLmvYBMlhe4wMeg==
X-Gm-Message-State: AOJu0Yx5NgzAHGKVEVMBzcJTaKAMrrNl6T15oF41wW17WtuZnQV91AKK
	c7THT2WFdslA3bwy2exxZXBL6OPioAw/3QIHYqseDYxZTIIBAk/Wn8p00FVm1AI=
X-Google-Smtp-Source: AGHT+IFPBkbU2aNYrXQ8809dzA+eKb9uiS2PXSzCao5t90cyhOzkMcMmTiaCTPqTvHS08OSljlo5Sg==
X-Received: by 2002:a17:902:7ed0:b0:1eb:dae:bdab with SMTP id d9443c01a7336-1ef43f4e315mr43128725ad.46.1715373039531;
        Fri, 10 May 2024 13:30:39 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:629e:3f2:f321:6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c138c04sm36433135ad.267.2024.05.10.13.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 13:30:38 -0700 (PDT)
Date: Fri, 10 May 2024 13:30:32 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	apatel@ventanamicro.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, sameo@rivosinc.com,
	shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 27/29] riscv: Documentation for landing pad / indirect
 branch tracking
Message-ID: <Zj6D6FqfbnEhcfqs@ghost>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-28-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403234054.2020347-28-debug@rivosinc.com>

On Wed, Apr 03, 2024 at 04:35:15PM -0700, Deepak Gupta wrote:
> Adding documentation on landing pad aka indirect branch tracking on riscv
> and kernel interfaces exposed so that user tasks can enable it.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  Documentation/arch/riscv/zicfilp.rst | 104 +++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/arch/riscv/zicfilp.rst
> 
> diff --git a/Documentation/arch/riscv/zicfilp.rst b/Documentation/arch/riscv/zicfilp.rst
> new file mode 100644
> index 000000000000..3007c81f0465
> --- /dev/null
> +++ b/Documentation/arch/riscv/zicfilp.rst
> @@ -0,0 +1,104 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Author: Deepak Gupta <debug@rivosinc.com>
> +:Date:   12 January 2024
> +
> +====================================================
> +Tracking indirect control transfers on RISC-V Linux
> +====================================================
> +
> +This document briefly describes the interface provided to userspace by Linux
> +to enable indirect branch tracking for user mode applications on RISV-V
> +
> +1. Feature Overview
> +--------------------
> +
> +Memory corruption issues usually result in to crashes, however when in hands of
> +an adversary and if used creatively can result into variety security issues.
> +
> +One of those security issues can be code re-use attacks on program where adversary
> +can use corrupt function pointers and chain them together to perform jump oriented
> +programming (JOP) or call oriented programming (COP) and thus compromising control
> +flow integrity (CFI) of the program.
> +
> +Function pointers live in read-write memory and thus are susceptible to corruption
> +and allows an adversary to reach any program counter (PC) in address space. On
> +RISC-V zicfilp extension enforces a restriction on such indirect control transfers
> +
> +	- indirect control transfers must land on a landing pad instruction `lpad`.
> +	  There are two exception to this rule
> +		- rs1 = x1 or rs1 = x5, i.e. a return from a function and returns are

What is a return that is not a return from a function?

> +		  protected using shadow stack (see zicfiss.rst)
> +
> +		- rs1 = x7. On RISC-V compiler usually does below to reach function
> +		  which is beyond the offset possible J-type instruction.
> +
> +			"auipc x7, <imm>"
> +			"jalr (x7)"
> +
> +		  Such form of indirect control transfer are still immutable and don't rely
> +		  on memory and thus rs1=x7 is exempted from tracking and considered software
> +		  guarded jumps.
> +
> +`lpad` instruction is pseudo of `auipc rd, <imm_20bit>` and is a HINT nop. `lpad`

I think this should say "x0" or instead of "rd", or mention that rd=x0.

> +instruction must be aligned on 4 byte boundary and compares 20 bit immediate with x7.
> +If `imm_20bit` == 0, CPU don't perform any comparision with x7. If `imm_20bit` != 0,
> +then `imm_20bit` must match x7 else CPU will raise `software check exception`
> +(cause=18)with `*tval = 2`.
> +
> +Compiler can generate a hash over function signatures and setup them (truncated
> +to 20bit) in x7 at callsites and function proglogs can have `lpad` with same

"prologues" instead of "proglogs"

> +function hash. This further reduces number of program counters a call site can
> +reach.
> +
> +2. ELF and psABI
> +-----------------
> +
> +Toolchain sets up `GNU_PROPERTY_RISCV_FEATURE_1_FCFI` for property
> +`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
> +
> +3. Linux enabling
> +------------------
> +
> +User space programs can have multiple shared objects loaded in its address space
> +and it's a difficult task to make sure all the dependencies have been compiled
> +with support of indirect branch. Thus it's left to dynamic loader to enable
> +indirect branch tracking for the program.
> +
> +4. prctl() enabling
> +--------------------
> +
> +`PR_SET_INDIR_BR_LP_STATUS` / `PR_GET_INDIR_BR_LP_STATUS` /
> +`PR_LOCK_INDIR_BR_LP_STATUS` are three prctls added to manage indirect branch
> +tracking. prctls are arch agnostic and returns -EINVAL on other arches.
> +
> +`PR_SET_INDIR_BR_LP_STATUS`: If arg1 `PR_INDIR_BR_LP_ENABLE` and if CPU supports
> +`zicfilp` then kernel will enabled indirect branch tracking for the task.
> +Dynamic loader can issue this `prctl` once it has determined that all the objects
> +loaded in address space support indirect branch tracking. Additionally if there is
> +a `dlopen` to an object which wasn't compiled with `zicfilp`, dynamic loader can
> +issue this prctl with arg1 set to 0 (i.e. `PR_INDIR_BR_LP_ENABLE` being clear)
> +
> +`PR_GET_INDIR_BR_LP_STATUS`: Returns current status of indirect branch tracking.
> +If enabled it'll return `PR_INDIR_BR_LP_ENABLE`
> +
> +`PR_LOCK_INDIR_BR_LP_STATUS`: Locks current status of indirect branch tracking on
> +the task. User space may want to run with strict security posture and wouldn't want
> +loading of objects without `zicfilp` support in it and thus would want to disallow
> +disabling of indirect branch tracking. In that case user space can use this prctl
> +to lock current settings.
> +
> +5. violations related to indirect branch tracking
> +--------------------------------------------------
> +
> +Pertaining to indirect branch tracking, CPU raises software check exception in
> +following conditions
> +	- missing `lpad` after indirect call / jmp
> +	- `lpad` not on 4 byte boundary
> +	- `imm_20bit` embedded in `lpad` instruction doesn't match with `x7`
> +
> +In all 3 cases, `*tval = 2` is captured and software check exception is raised
> +(cause=18)
> +
> +Linux kernel will treat this as `SIGSEV`` with code = `SEGV_CPERR` and follow
> +normal course of signal delivery.
> -- 
> 2.43.2
> 

