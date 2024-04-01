Return-Path: <linux-arch+bounces-3346-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989858939C2
	for <lists+linux-arch@lfdr.de>; Mon,  1 Apr 2024 11:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04180B219A9
	for <lists+linux-arch@lfdr.de>; Mon,  1 Apr 2024 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B3110A08;
	Mon,  1 Apr 2024 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IKkpukb8"
X-Original-To: linux-arch@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905DE1095A;
	Mon,  1 Apr 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964889; cv=none; b=iMxA5RUze03NOGMcnJ8ey3HJAXlIoaLgkq1TDpE2oLgpzPzsDKZFmDIV8yoELl0JZF51VeMpx6OZ9S5yFPhw1SC6NncsC+OXqr4PQIgzbBj0QmfxL/gViIw+e1F+SJsPR86onPtH3gfvHqGqYe2hJOoIQ9gNc50YJpvsih3zuLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964889; c=relaxed/simple;
	bh=06wOk/U0MualMJ4bunj44L58B9nb+s9Iaqf0BY9Iihk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R0fbu7d0cnvSSeCj3pCBCiwTZkqtlB0XIWrn59lYf7ez8ee3gzmrVeKm1j3rIsioVzGqIXa3ofzsMpcbtw5Vexqdb8RoimQje0WX9K0wZ1LnLPsPeaMuX612eLaUce6H4YpULPJoreYQraGH9UGwICmVPk39VF6Ck1/EyuxJV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IKkpukb8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711964885;
	bh=06wOk/U0MualMJ4bunj44L58B9nb+s9Iaqf0BY9Iihk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=IKkpukb884sj8Eg4Yw/1yM6F+jVI41WbIFR5wppl38DPIFzg7d+snPhJSh90a3YbB
	 6UxRTezpSmT4wNQmWC70hAfP/JxH0Ch921mvOmRMG6ao7uQPIuZ7OsFD7KR2aH5N87
	 tG0r+nrikfEXbQvrvlxX1XWEKAWH5gay7UPdFl6DDuIhYIr3WnRTZy/d4En7a/hkhB
	 ryU3/OINHUKgVPtbeLhy24Ru35rCA0iPfjdVytimtX+uverHEJe3H4njiECn3UAPIe
	 pNY86YqfqdyTKZh6NivIn+8POtsgH3Jxd+ULYNYtQQqgOUeGD7ZqZngxjW5K5IDaXk
	 qoDfDq7BJ5Z5Q==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8BFC2378148F;
	Mon,  1 Apr 2024 09:47:23 +0000 (UTC)
Message-ID: <ef72ae20-6b68-496a-a819-8818ade0d433@collabora.com>
Date: Mon, 1 Apr 2024 14:46:13 +0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 paul.walmsley@sifive.com, rick.p.edgecombe@intel.com, broonie@kernel.org,
 Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, keescook@chromium.org,
 ajones@ventanamicro.com, conor.dooley@microchip.com, cleger@rivosinc.com,
 atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
 alexghiti@rivosinc.com, samuel.holland@sifive.com, palmer@sifive.com,
 conor@kernel.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, corbet@lwn.net,
 tech-j-ext@lists.risc-v.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
 akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
 shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
 jerry.shih@sifive.com, hankuan.chen@sifive.com, greentime.hu@sifive.com,
 evan@rivosinc.com, xiao.w.wang@intel.com, charlie@rivosinc.com,
 apatel@ventanamicro.com, mchitale@ventanamicro.com,
 dbarboza@ventanamicro.com, sameo@rivosinc.com, shikemeng@huaweicloud.com,
 willy@infradead.org, vincent.chen@sifive.com, guoren@kernel.org,
 samitolvanen@google.com, songshuaishuai@tinylab.org, gerg@kernel.org,
 heiko@sntech.de, bhe@redhat.com, jeeheng.sia@starfivetech.com,
 cyy@cyyself.name, maskray@google.com, ancientmodern4@gmail.com,
 mathis.salmen@matsal.de, cuiyunhui@bytedance.com, bgray@linux.ibm.com,
 mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, david@redhat.com,
 catalin.marinas@arm.com, revest@chromium.org, josh@joshtriplett.org,
 shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
 jhubbard@nvidia.com
Subject: Re: [PATCH v2 27/27] kselftest/riscv: kselftest for user mode cfi
To: Deepak Gupta <debug@rivosinc.com>
References: <20240329044459.3990638-1-debug@rivosinc.com>
 <20240329044459.3990638-28-debug@rivosinc.com>
 <4b38393a-f69d-4a77-a896-b6cd42c7edcf@collabora.com>
 <CAKC1njQ_RU=uHhrna=MFVdjAMjjQNqZWnkjPoJvO7CxtPMeNuQ@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAKC1njQ_RU=uHhrna=MFVdjAMjjQNqZWnkjPoJvO7CxtPMeNuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/30/24 1:02 AM, Deepak Gupta wrote:
> On Fri, Mar 29, 2024 at 12:50 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 3/29/24 9:44 AM, Deepak Gupta wrote:
>>> Adds kselftest for RISC-V control flow integrity implementation for user
>>> mode. There is not a lot going on in kernel for enabling landing pad for
>>> user mode. Thus kselftest simply enables landing pad for the binary and
>>> a signal handler is registered for SIGSEGV. Any control flow violation are
>>> reported as SIGSEGV with si_code = SEGV_CPERR. Test will fail on recieving
>>> any SEGV_CPERR. Shadow stack part has more changes in kernel and thus there
>>> are separate tests for that
>>>       - enable and disable
>>>       - Exercise `map_shadow_stack` syscall
>>>       - `fork` test to make sure COW works for shadow stack pages
>>>       - gup tests
>>>         As of today kernel uses FOLL_FORCE when access happens to memory via
>>>         /proc/<pid>/mem. Not breaking that for shadow stack
>>>       - signal test. Make sure signal delivery results in token creation on
>>>       shadow stack and consumes (and verifies) token on sigreturn
>>>     - shadow stack protection test. attempts to write using regular store
>>>         instruction on shadow stack memory must result in access faults
>>>
>>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>> ---
>>>  tools/testing/selftests/riscv/Makefile        |   2 +-
>>>  tools/testing/selftests/riscv/cfi/Makefile    |  10 +
>>>  .../testing/selftests/riscv/cfi/cfi_rv_test.h |  85 ++++
>>>  .../selftests/riscv/cfi/riscv_cfi_test.c      |  91 +++++
>>>  .../testing/selftests/riscv/cfi/shadowstack.c | 376 ++++++++++++++++++
>>>  .../testing/selftests/riscv/cfi/shadowstack.h |  39 ++
>> Please add generated binaries in the .gitignore files.
> 
> hmm...
> I don't see binary as part of the patch. Which file are you referring
> to here being binary?
shadowstack would be generated by the build. Create a .gitignore file and
add it there. For example, look at
tools/testing/selftests/riscv/vector/.gitignore to understand.


> 
>>
> 

-- 
BR,
Muhammad Usama Anjum

