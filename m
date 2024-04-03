Return-Path: <linux-arch+bounces-3430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6354897CA4
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 01:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCD8B28E7C
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 23:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861C115E7F9;
	Wed,  3 Apr 2024 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sPnbOn2H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B134F15E5D2
	for <linux-arch@vger.kernel.org>; Wed,  3 Apr 2024 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187772; cv=none; b=BAy+Jb8goTJIqC+Piy37mrLaEV7y0ABHcc5NkggJUkwtSdbvgJaWLo/bwKP2XOMthGB0X0sghWXADneXC0NzSL9OklyIxtTLTRp4u5wGazYWs3fFJ/eXANLwTeLIQtj72RarqOOXDTpixE91XHAZYdTdxU3sRqs6QnFZsj98VCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187772; c=relaxed/simple;
	bh=z8zm7XjjzBT/3WDLCQHlDrJcAMj4PRm7YR0EyNzWyTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdDDWcLegK1/2QalBfxRa7WvEspRTK/uODYkoau3dob0IknMYKQGdZXnPX3z8feH4HiUqRqDcDHWMqYUH5IMYNnbLXHrjYgkT0DmDCzhEBd9/JFY8tO+uhQRCNz2SP7WLVLI4/yo9QGnnvYz0t4JwMK3/P5g35lqZ4JrsVASWOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sPnbOn2H; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e74aa08d15so304323b3a.1
        for <linux-arch@vger.kernel.org>; Wed, 03 Apr 2024 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187770; x=1712792570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5ifazHbpOl/UA3v79b+PzDDuljcd/dBpmVrUfFdj7c=;
        b=sPnbOn2HM3325PoS9GP4NNms66QbpmCAtl7KTHnqB2LohbRfNMITjl5bk2R/KhsFgL
         a/Jxg9/nCiqETUkTYp0BTM8oRNq7LjGNgiwoMwrK0Qn7weXiulmkNigj5w6EW9m8I4jd
         wj9luVTD+kIwvMgEMLDWTr6Lcrz1igFJ85a1AxsKB8gLcJ8sxgQ9kFOpRjnWPiaegK9B
         ZYpWVsiIH7x1r7yq4JL124oq6n/LcLo8ycE0YhrHg3idyodGYzGJbvtfqpdendrbxPXI
         eiCZXRUEY/t3vz5n96VhA5RCjqhoOJsihyWuif8mPYeaapYiDHPSvwU0IwrVplT12dxh
         TDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187770; x=1712792570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5ifazHbpOl/UA3v79b+PzDDuljcd/dBpmVrUfFdj7c=;
        b=G/wMqGYkaps5dV2yewyPK2u4/UMrjNpZExNHua/XRQj9wb6kEcp2o4v2Zy3rvLOeb0
         m4+DvzGtAblBntzM87wQHY2UzUZKvd0yu58HqSEu1bu8VFyhfCQF9u03NlQGX8FpA/Xz
         jfEvfcvRkPZSxhu0dIkuwwviMlU/suiBLHESUY6PJSRJvCVuo+CPWA3flijbuFxbeK8Y
         81qsNzPuTKDDPR3h2JgRnzYhRk4KccM/7ZDUG7dpNLUwam2Nm6iMyLl/RGk1BGaJYS0J
         icwzOeqFsIJyRLYYe5ukgRKUhv8K/vqcbpZY6Shu2iAQNWV9s7lvumq0v+YYxH3lsBR1
         oHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVejH3fvPaBBcVKiQsC02xwVI9fQ6cus4oWsKa/2xALV7mUw/siVkxPghQ5ekt5Sd5TplWBbe49bCgSKm4NfVAn6O2NKNjhhUzSkw==
X-Gm-Message-State: AOJu0YzuV5WMgYRF91BkNro/RKj+BReri33jHoS7yiKXn9pbruatO0Cx
	hTN+RSWiy7OL9LWDfTj43pcX1W4VLSqMbPBXLXbRzhCkeB9youZ9Qb41hMiRYL8=
X-Google-Smtp-Source: AGHT+IFOcGirbQfLQaLb5+nO2ahsn6EhtiBDapL2BrJtt/8rvvrO0dXtCiXExOYOg70SFiumQnh5iA==
X-Received: by 2002:a05:6a20:3d03:b0:1a3:3fbd:f859 with SMTP id y3-20020a056a203d0300b001a33fbdf859mr1489558pzi.2.1712187769990;
        Wed, 03 Apr 2024 16:42:49 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:42:49 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	conor@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v3 27/29] riscv: Documentation for landing pad / indirect branch tracking
Date: Wed,  3 Apr 2024 16:35:15 -0700
Message-ID: <20240403234054.2020347-28-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403234054.2020347-1-debug@rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding documentation on landing pad aka indirect branch tracking on riscv
and kernel interfaces exposed so that user tasks can enable it.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 Documentation/arch/riscv/zicfilp.rst | 104 +++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/arch/riscv/zicfilp.rst

diff --git a/Documentation/arch/riscv/zicfilp.rst b/Documentation/arch/riscv/zicfilp.rst
new file mode 100644
index 000000000000..3007c81f0465
--- /dev/null
+++ b/Documentation/arch/riscv/zicfilp.rst
@@ -0,0 +1,104 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Deepak Gupta <debug@rivosinc.com>
+:Date:   12 January 2024
+
+====================================================
+Tracking indirect control transfers on RISC-V Linux
+====================================================
+
+This document briefly describes the interface provided to userspace by Linux
+to enable indirect branch tracking for user mode applications on RISV-V
+
+1. Feature Overview
+--------------------
+
+Memory corruption issues usually result in to crashes, however when in hands of
+an adversary and if used creatively can result into variety security issues.
+
+One of those security issues can be code re-use attacks on program where adversary
+can use corrupt function pointers and chain them together to perform jump oriented
+programming (JOP) or call oriented programming (COP) and thus compromising control
+flow integrity (CFI) of the program.
+
+Function pointers live in read-write memory and thus are susceptible to corruption
+and allows an adversary to reach any program counter (PC) in address space. On
+RISC-V zicfilp extension enforces a restriction on such indirect control transfers
+
+	- indirect control transfers must land on a landing pad instruction `lpad`.
+	  There are two exception to this rule
+		- rs1 = x1 or rs1 = x5, i.e. a return from a function and returns are
+		  protected using shadow stack (see zicfiss.rst)
+
+		- rs1 = x7. On RISC-V compiler usually does below to reach function
+		  which is beyond the offset possible J-type instruction.
+
+			"auipc x7, <imm>"
+			"jalr (x7)"
+
+		  Such form of indirect control transfer are still immutable and don't rely
+		  on memory and thus rs1=x7 is exempted from tracking and considered software
+		  guarded jumps.
+
+`lpad` instruction is pseudo of `auipc rd, <imm_20bit>` and is a HINT nop. `lpad`
+instruction must be aligned on 4 byte boundary and compares 20 bit immediate with x7.
+If `imm_20bit` == 0, CPU don't perform any comparision with x7. If `imm_20bit` != 0,
+then `imm_20bit` must match x7 else CPU will raise `software check exception`
+(cause=18)with `*tval = 2`.
+
+Compiler can generate a hash over function signatures and setup them (truncated
+to 20bit) in x7 at callsites and function proglogs can have `lpad` with same
+function hash. This further reduces number of program counters a call site can
+reach.
+
+2. ELF and psABI
+-----------------
+
+Toolchain sets up `GNU_PROPERTY_RISCV_FEATURE_1_FCFI` for property
+`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
+
+3. Linux enabling
+------------------
+
+User space programs can have multiple shared objects loaded in its address space
+and it's a difficult task to make sure all the dependencies have been compiled
+with support of indirect branch. Thus it's left to dynamic loader to enable
+indirect branch tracking for the program.
+
+4. prctl() enabling
+--------------------
+
+`PR_SET_INDIR_BR_LP_STATUS` / `PR_GET_INDIR_BR_LP_STATUS` /
+`PR_LOCK_INDIR_BR_LP_STATUS` are three prctls added to manage indirect branch
+tracking. prctls are arch agnostic and returns -EINVAL on other arches.
+
+`PR_SET_INDIR_BR_LP_STATUS`: If arg1 `PR_INDIR_BR_LP_ENABLE` and if CPU supports
+`zicfilp` then kernel will enabled indirect branch tracking for the task.
+Dynamic loader can issue this `prctl` once it has determined that all the objects
+loaded in address space support indirect branch tracking. Additionally if there is
+a `dlopen` to an object which wasn't compiled with `zicfilp`, dynamic loader can
+issue this prctl with arg1 set to 0 (i.e. `PR_INDIR_BR_LP_ENABLE` being clear)
+
+`PR_GET_INDIR_BR_LP_STATUS`: Returns current status of indirect branch tracking.
+If enabled it'll return `PR_INDIR_BR_LP_ENABLE`
+
+`PR_LOCK_INDIR_BR_LP_STATUS`: Locks current status of indirect branch tracking on
+the task. User space may want to run with strict security posture and wouldn't want
+loading of objects without `zicfilp` support in it and thus would want to disallow
+disabling of indirect branch tracking. In that case user space can use this prctl
+to lock current settings.
+
+5. violations related to indirect branch tracking
+--------------------------------------------------
+
+Pertaining to indirect branch tracking, CPU raises software check exception in
+following conditions
+	- missing `lpad` after indirect call / jmp
+	- `lpad` not on 4 byte boundary
+	- `imm_20bit` embedded in `lpad` instruction doesn't match with `x7`
+
+In all 3 cases, `*tval = 2` is captured and software check exception is raised
+(cause=18)
+
+Linux kernel will treat this as `SIGSEV`` with code = `SEGV_CPERR` and follow
+normal course of signal delivery.
-- 
2.43.2


