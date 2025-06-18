Return-Path: <linux-arch+bounces-12364-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0244ADE8D9
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 12:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152433B5991
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 10:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FF2283137;
	Wed, 18 Jun 2025 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KrwKCEtF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF127FB16;
	Wed, 18 Jun 2025 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242078; cv=none; b=Hop1btReYr79onsNUDs94EmqmpPLNBSlFkBUxw4czIMrokIWKGNmIF7Nye8oGMkxhOtwEebjgZbO95QmVPX3BFBeUys98B0lzVCiOlI002VaaRuHetqRQ1d9sNw8JLA9EMdoNlttSSHXqV6N0cWDht+cIeYupn07I2yhCUZ6sEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242078; c=relaxed/simple;
	bh=Ro329G7e6bLXxjcm0ncpB4tvjdXFieVigZAwXeLjE/g=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=gMHop0TCUvfOakOjpG/kA86r2EYnE7H9knJQMfgUUl5kYGO3H7W+hBfdIWQCcsRn49G3R8VbpnqdduCPoL0myhZ12+F58W91tC2vr/kmaXBXZS8ISH0Qd8+jtldSZaOrnWDuTBFXpexqrrRSYSB389I2VErtJFvg3pPaoWKzreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KrwKCEtF; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bMfsN1fTbz9t9P;
	Wed, 18 Jun 2025 12:21:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750242072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lT6i+pbNHdJMMvp/mp0MakBah9wX4+JxXhdBuviIlyM=;
	b=KrwKCEtFvAN+VBa7X22Xk0JlI3P8RyAPLy8FQDaEiWIH3lDrLPI9CO62TdV2kxVNhS6f5Y
	dSinq5vA+pZShA6qqSi7xDFa5ysleiSeH39khZur18pt/w06CJvNtl42rbxNvzDqZVlB5e
	NAd+kVoSdKJhiGNq1fITWtHd1b6aDLx/4yaV7hAaLdNsUPVmDbY5icQYBKNKrg0Zm2AHcY
	tt/M1aqqk1uXhTov8+c8aV2X9m76pcrP3SGL3e8/u5s/d87NzhNtCS8wDM8fkc2Str4V9W
	3PrBBB7T9dcgU6L+M7KOid2sShijvjCxWtce775GtirlSLX8Fiy0ygp6NrIMeQ==
Date: Wed, 18 Jun 2025 12:21:07 +0200 (CEST)
From: Jakub Wartak <jakub.wartak@mailbox.org>
To: "anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"andreyknvl@gmail.com" <andreyknvl@gmail.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dave.hansen@intel.com" <dave.hansen@intel.com>,
	"david@redhat.com" <david@redhat.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"khalid@kernel.org" <khalid@kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"luto@kernel.org" <luto@kernel.org>,
	"markhemm@googlemail.com" <markhemm@googlemail.com>,
	"maz@kernel.org" <maz@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"neilb@suse.de" <neilb@suse.de>, "pcc@google.com" <pcc@google.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"vasily.averin@linux.dev" <vasily.averin@linux.dev>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"willy@infradead.org" <willy@infradead.org>,
	"xhao@linux.alibaba.com" <xhao@linux.alibaba.com>
Message-ID: <1968222200.618999.1750242067613@office-sso.mailbox.org>
Subject: Re: [PATCH v2 00/20] Add support for shared PTEs across processes
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-META: t8iza63jxqhrn5fkefnmh6rdkxx9a7zh
X-MBO-RS-ID: afb4a33d23cd47279ad

Hi all,

I wanted to share some results. I modified PostgreSQL (master) to use the proposed here msharefs patchset (v2) on top of linux-6.14.7 kernel as I suspected sharing PTEs might be helpful in some cases, especially with high process counts. Traditionally in PostgreSQL having process counts is an anti-pattern and it's not recommended (for various reasons) to have that many backends (process) running, but I was researching for the exact reasons why (there are plenty others too), but in short that's how I suspected dTLB misses, followed up on PTEs and finally arrived here: msharefs.

I've tried it on a couple scenarios and it always helps (+5% .. 40%) in artificial pgbench readonly measurements on any machine, but here I'm posting results:
a. from some properly isolated legacy SMP box in homelab (4s32c64/4xNUMA nodes, Xeon 46xx, 128GB RAM)
b. PostgreSQL's pgbench OLTP-like benchmark was used with -c $c -j 64 -S -T 60 -P 1
c. PostgreSQLs shared_buffers(shared_memory)=32GB
d. pgbench -i -s 2000 (~31GB, all used data was in shared memory, not in VFS cache, to avoid syscalls),
e. no hugepages were used as msharefs seems to not support it yet (but Anthony already told me he's on it) 
f. I've used cpupower with perf governor, D0 and no_turbo as well and data was prewarmed.

Again, having PostgreSQL with 8k or 16k processes is not the way to go, but it illustrates well that fork() model (1 client = 1 process) can really benefit from msharefs:

shared_memory_type=mmap (default on Linux is mmap(MAP_SHARED)+fork())
 c=8000 tps  = 143-150k (~4s to init all conns)
 c=16000 tps = 130-140k (~50s-70s! to init all conns! had to extend benchmark, lots of fork()!)

shared_memory_type=msharefs (literally same as above, open()/fallocate()/ioctl()/mmap()+fork()):
 c=8000 tps  = ~189k (3s to init all conns)
 c=16000 tps = ~189k (6s to init all conns)

That's 1.35x - 1.45x.

Illustrative sample of 1 second of `perf stat -a -e ...` during those run with 16k processes:

# mmap:
#           time             counts unit events
   190.223101118        15257144598      cycles
   190.223101118        10485389437      instructions                     #    0.69  insn per cycle
   190.223101118              34413      context-switches
   190.223101118                703      cpu-migrations
   190.223101118                  0      major-faults
   190.223101118             256302      minor-faults
   190.223101118         3922621887      dTLB-loads
   190.223101118           12520660      dTLB-load-misses                 #    0.32% of all dTLB cache accesses
   
# msharefs:
#           time             counts unit events
   105.122916131        15256454170      cycles
   105.122916131        10732582790      instructions                     #    0.70  insn per cycle
   105.122916131              38420      context-switches
   105.122916131               1125      cpu-migrations
   105.122916131                  0      major-faults
   105.122916131              34304      minor-faults
   105.122916131         4143569524      dTLB-loads
   105.122916131           12179260      dTLB-load-misses                 #    0.29% of all dTLB cache accesses 

On smaller hardware and single socket there are also such gains even on the lower process counts, but the more process are running concurrently and accessing shared memory the bigger the performance boost. I hope this feedback is useful (so it's not only lowering memory use for PTEs, but also quite a nice perf. boost). I would like too to thank Anthony and Khalid for answering some initial questions outside mailing list.

BTW I have not yet posted it to PostgreSQL main hacking mailing list, well... because there's no kernel in the first place to support that ;)

-J.

p.s. I'm not subscribed to linux-mm, so please CC me.

