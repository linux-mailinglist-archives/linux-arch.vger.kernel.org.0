Return-Path: <linux-arch+bounces-11354-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B191BA827C6
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 16:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A858C04BC
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 14:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB466265CB5;
	Wed,  9 Apr 2025 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="umQqvzTV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473A26562A
	for <linux-arch@vger.kernel.org>; Wed,  9 Apr 2025 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208777; cv=none; b=rf81DlaJwGaqRnGOW5jRfn1rurwyJhTz7Myiw5Iqy4J5SD2QhRLyocjxlq4xe32zfNzbxhMbwqxQzEwOPGzfuQ1XUFjmrTAwfu1RaoU4BhHC4Yo+vqTFeME7iTbkvTRgTQSblyVunO6hfu+pBjuSXOnZm/yf+BYBADO17CHko7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208777; c=relaxed/simple;
	bh=XzrQ0mp7WLZBCaR1QiDf7RGSn7Hx8B/2cG3auHEmO9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1q07D43lXEZCn+AI/5GSyT8qVrDS3l4NPp/3XEf/ukfOZIUeQOub5pSlwm0quQ4D0/7qOfSDUMUGBX01Gu3JYFkqbrYTvjjSQDgIr0BlzQjgUiZoSDPWWns4uK/6swtfgSsEJWhRukA/QkRRuLrV0Wm249ZsR6nXPewVakJw6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=umQqvzTV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso9172889b3a.2
        for <linux-arch@vger.kernel.org>; Wed, 09 Apr 2025 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744208774; x=1744813574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWCFSwSJdWVyuiq1FZlofUemWkrK3y3F0Kcxx42yGpc=;
        b=umQqvzTVILzhPynzAwi5LSrvh4hAJ6dAjyd8WMlFATXucc4vGYSGANwv1sIoGsv9Ag
         QxpMMWyRhT1lbu7asOtH7joFr8NY0vj0RGMAWyNztZMKNdY3sSLYSaz/JFGFY6UYG+vo
         6G4tZadO83UvhefAdvC+nDbItDx9Uv0NQx6rqOxvAxuTWUHaBuz0/JdQet30IEpFqqh7
         HrLAbiCLj+nJHnoYaTGkwdM5DedcPbDHsEhXNZslw7gpU64Y9LinYhCQz1+VkIlXBkpn
         DPQNEoVV/yts7C3SPaJYmHRvuFjaTWKRR/zPcvTTniYNkdiMGtFTwQkg+xHpf9RdXHC8
         2L9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744208774; x=1744813574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWCFSwSJdWVyuiq1FZlofUemWkrK3y3F0Kcxx42yGpc=;
        b=oKKIB/fQKZp2Wr4Nlkvga8ZPVLcVGUCinswl2nWfQxln/xs5/o72O1pTrXPhjgah9r
         g+15/NTrY0x4z2HVQSVAwexKChAX49PbvjnAyAnv8i+oLICl7X0GiK67UYu4/lk6+/5Z
         QiZEVPsLSxHtU4Ee/2/MqYEISpQWC1E598Ow+fPFWRKmEFunBH3uG0Fbfo8IVQf4Th48
         qcSECAaM67N28dqIvlnRLnOfYh1FhmEH62t28XzjSYppkDBKgpTkkM6KA0lenFGZ+2Uq
         +uOjzVkq4O5xUs7vYUmJiySAdoy/JNVKpCXcwhcXRwr6Ijx+N7nqPyu+PgKOFK5GkGv3
         A/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBBgocKy1JExqVCQ3XTtwvvGcNG94KoZzj3Gmeh+e/9JNU8LNttbH7QQPqBTnGjVrUsDC2LWZBeG0i@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSAu5/gX1O2sl7sD87f3bxvk/xvUxjb03M5O3MX5pA8d2XK4p
	7v+Y7CvOHdtl/cY+SIhF5aDwP9x5rU/pFUavSG+yNRUAoKN6C60JBzJZShoSbEg=
X-Gm-Gg: ASbGncs4KYeinmnxoYKMMC5Om2I5Oa/UtkrmnXEsKXDORzzQZ0wWw5+qqh2PHMvBfcQ
	iXZnVhsLpHZKGo62yuA8emwiojhtUpJEvuvJgM+U6EF31iPNeM70JjKVc24CUYfdxctI/FaEQlr
	0ZjBx8a9ADdigiXcyrerkwYQOd/BMTUwrQyml3PLzT07IYQGS3uk19hpYrAV8Ot6q8JQGc3MJM3
	z2hpVFxE5VQo6OxjsdjOW/96XpdPmxrRj+736mey1weljyf4EN2cH3jxjwbzWAWpRIiEuHenty5
	vnfWy9ggTLNnBxBhjJlpvObkD2KImzfb4kX0zKSrCsb+w37JXoU=
X-Google-Smtp-Source: AGHT+IHFFMUtgc5GdaqhKowOEcwpQuVaNNQv/0+QvYg71I8MlHsNAHS1sjVjRx/1bLRC7yOHjj+PuA==
X-Received: by 2002:a05:6a00:e12:b0:736:a973:748 with SMTP id d2e1a72fcca58-73bafd6a4a1mr3511930b3a.22.1744208774241;
        Wed, 09 Apr 2025 07:26:14 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2b108sm1426136b3a.19.2025.04.09.07.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:26:13 -0700 (PDT)
Date: Wed, 9 Apr 2025 07:26:10 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
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
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: [PATCH v12 13/28] prctl: arch-agnostic prctl for indirect branch
 tracking
Message-ID: <Z_aDgnfI3_LKHdfb@debug.ba.rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-13-e51202b53138@rivosinc.com>
 <fdf8f812-ae36-4327-b345-2df047b85e7a@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fdf8f812-ae36-4327-b345-2df047b85e7a@ghiti.fr>

On Wed, Apr 09, 2025 at 10:03:05AM +0200, Alexandre Ghiti wrote:
>On 14/03/2025 22:39, Deepak Gupta wrote:
>>Three architectures (x86, aarch64, riscv) have support for indirect branch
>>tracking feature in a very similar fashion. On a very high level, indirect
>>branch tracking is a CPU feature where CPU tracks branches which uses
>>memory operand to perform control transfer in program. As part of this
>>tracking on indirect branches, CPU goes in a state where it expects a
>>landing pad instr on target and if not found then CPU raises some fault
>>(architecture dependent)
>>
>>x86 landing pad instr - `ENDBRANCH`
>>arch64 landing pad instr - `BTI`
>>riscv landing instr - `lpad`
>>
>>Given that three major arches have support for indirect branch tracking,
>>This patch makes `prctl` for indirect branch tracking arch agnostic.
>>
>>To allow userspace to enable this feature for itself, following prtcls are
>>defined:
>>  - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect
>>    branch tracking.
>>  - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch
>>    tracking.
>>    Following status options are allowed
>>        - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
>>          thread.
>>        - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on user
>>          thread.
>>  - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branch
>>    tracking for user thread.
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>Reviewed-by: Mark Brown <broonie@kernel.org>
>>---
>>  include/linux/cpu.h        |  4 ++++
>>  include/uapi/linux/prctl.h | 27 +++++++++++++++++++++++++++
>>  kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
>>  3 files changed, 61 insertions(+)
>>
>>diff --git a/include/linux/cpu.h b/include/linux/cpu.h
>>index 6a0a8f1c7c90..fb0c394430c6 100644
>>--- a/include/linux/cpu.h
>>+++ b/include/linux/cpu.h
>>@@ -204,4 +204,8 @@ static inline bool cpu_mitigations_auto_nosmt(void)
>>  }
>>  #endif
>>+int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status);
>>+int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status);
>>+int arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long status);
>>+
>>  #endif /* _LINUX_CPU_H_ */
>>diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>>index 5c6080680cb2..6cd90460cbad 100644
>>--- a/include/uapi/linux/prctl.h
>>+++ b/include/uapi/linux/prctl.h
>>@@ -353,4 +353,31 @@ struct prctl_mm_map {
>>   */
>>  #define PR_LOCK_SHADOW_STACK_STATUS      76
>>+/*
>>+ * Get the current indirect branch tracking configuration for the current
>>+ * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STATUS.
>>+ */
>>+#define PR_GET_INDIR_BR_LP_STATUS      77
>>+
>>+/*
>>+ * Set the indirect branch tracking configuration. PR_INDIR_BR_LP_ENABLE will
>>+ * enable cpu feature for user thread, to track all indirect branches and ensure
>>+ * they land on arch defined landing pad instruction.
>>+ * x86 - If enabled, an indirect branch must land on `ENDBRANCH` instruction.
>>+ * arch64 - If enabled, an indirect branch must land on `BTI` instruction.
>>+ * riscv - If enabled, an indirect branch must land on `lpad` instruction.
>>+ * PR_INDIR_BR_LP_DISABLE will disable feature for user thread and indirect
>>+ * branches will no more be tracked by cpu to land on arch defined landing pad
>>+ * instruction.
>>+ */
>>+#define PR_SET_INDIR_BR_LP_STATUS      78
>>+# define PR_INDIR_BR_LP_ENABLE		   (1UL << 0)
>
>
>Are we missing PR_INDIR_BR_LP_DISABLE definition here?

PR_SET_INDIR_BR_LP_STATUS with parameter's bit0 clear will disable branch tracking.
This is what arm and riscv settled on for shadow stack enable and disable as well.
>
>
>>+
>>+/*
>>+ * Prevent further changes to the specified indirect branch tracking
>>+ * configuration.  All bits may be locked via this call, including
>>+ * undefined bits.
>>+ */
>>+#define PR_LOCK_INDIR_BR_LP_STATUS      79
>>+
>>  #endif /* _LINUX_PRCTL_H */
>>diff --git a/kernel/sys.c b/kernel/sys.c
>>index cb366ff8703a..f347f3518d0b 100644
>>--- a/kernel/sys.c
>>+++ b/kernel/sys.c
>>@@ -2336,6 +2336,21 @@ int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long st
>>  	return -EINVAL;
>>  }
>>+int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
>>+{
>>+	return -EINVAL;
>>+}
>>+
>>+int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
>>+{
>>+	return -EINVAL;
>>+}
>>+
>>+int __weak arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long status)
>>+{
>>+	return -EINVAL;
>>+}
>>+
>>  #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
>>  #ifdef CONFIG_ANON_VMA_NAME
>>@@ -2811,6 +2826,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>  			return -EINVAL;
>>  		error = arch_lock_shadow_stack_status(me, arg2);
>>  		break;
>>+	case PR_GET_INDIR_BR_LP_STATUS:
>>+		if (arg3 || arg4 || arg5)
>>+			return -EINVAL;
>>+		error = arch_get_indir_br_lp_status(me, (unsigned long __user *)arg2);
>>+		break;
>>+	case PR_SET_INDIR_BR_LP_STATUS:
>>+		if (arg3 || arg4 || arg5)
>>+			return -EINVAL;
>>+		error = arch_set_indir_br_lp_status(me, arg2);
>>+		break;
>>+	case PR_LOCK_INDIR_BR_LP_STATUS:
>>+		if (arg3 || arg4 || arg5)
>>+			return -EINVAL;
>>+		error = arch_lock_indir_br_lp_status(me, arg2);
>>+		break;
>>  	default:
>>  		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
>>  		error = -EINVAL;
>>

