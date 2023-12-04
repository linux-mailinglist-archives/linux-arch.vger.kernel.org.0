Return-Path: <linux-arch+bounces-645-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4FC803B6C
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 18:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B49281035
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2932E837;
	Mon,  4 Dec 2023 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+urM3M4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D54B83;
	Mon,  4 Dec 2023 09:25:39 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c08af319cso18909375e9.2;
        Mon, 04 Dec 2023 09:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701710738; x=1702315538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/67VX4B4sjgrRJxe42EkDnSLKfXlU5YkrCZ/4KluE8=;
        b=I+urM3M4+CAHDXtCKxwIs0mJSkskdD6iG6EvyJl4iQoZa41KPE6paklhGPhWmQt22O
         aXq0a89W9L6nzIuVFbOCVod51KaagSoCXzp8blRpSfgqpH6h2shAzMFW09IDV6kvWOnS
         TRSAN9p4b9sysriS3ICvi87I2UsTwKbABSsr13fT2JNEBSO7alttdQe95L+/1MEBoAsI
         IhqcETlm8Oi1629gDieXlshavYrTBBkYuDlBegE2Z1xRpWaqAbIa+12u3y2IgX0EBlBa
         LlqZ4lTUTKSPNHeapTGwVWVkKfwvXmG/yHeEzVLqz4uVzgtqsBtkiKG1GehWKwzSQW6C
         rukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710738; x=1702315538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/67VX4B4sjgrRJxe42EkDnSLKfXlU5YkrCZ/4KluE8=;
        b=UPN52DtaC9wY+MjsPUVPAWYMti9mdu+iTy6x11KLsBBaOgKFdRRiskYQQFDhqeq5m1
         /flo0IwOlrKSgy3hcEvbumocp+wtgbzl0nZv1q4jmwKu2VJ2p7itQ6UDHplCGPkbBNCV
         M3nC2DoTrUZd0W4HBnkdXMAwzORLwwokAC2aJQ3UXFNkkK9fY1SRwnAU1G3LiHd5ialk
         xNDVtJKkCB9zwbDrdhQo1Ci/uwlwlrNN2SPqbzzmU2t/LoeL5wLE/BGPRG2Q5P+DspW2
         0k83rDJr5C07nZ6Ga0Fg8sorIRe11d/W6lRuL6Mi1mTnYqXzIYovBNaa9hfnaHaw99f/
         zkeQ==
X-Gm-Message-State: AOJu0Yys5nrf+tAL2Lg8YLfdh1qjnopyX7gsIam9kgXmEqdbSAjay18j
	Pws7OATmMI3cCMgKfMYucLw=
X-Google-Smtp-Source: AGHT+IH+4eUTn1wB6eNuU4GMd08OsofYLBoZfpeY7NFDBH3guemfxBUQp4MObpRWTuNwklKuM9aYnQ==
X-Received: by 2002:a05:600c:1d94:b0:40b:5e21:ec28 with SMTP id p20-20020a05600c1d9400b0040b5e21ec28mr2583746wms.90.1701710737464;
        Mon, 04 Dec 2023 09:25:37 -0800 (PST)
Received: from krava ([83.240.63.158])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c1d9700b0040b3645a7c2sm19657919wms.40.2023.12.04.09.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:25:37 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 4 Dec 2023 18:25:34 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Song Liu <song@kernel.org>, Song Liu <songliubraving@meta.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Joao Moreira <joao@overdrivepizza.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] x86/cfi,bpf: Fix BPF JIT call
Message-ID: <ZW4LjmUKj1q6RWdL@krava>
References: <20231130133630.192490507@infradead.org>
 <20231130134204.136058029@infradead.org>
 <CAADnVQJqE=aE7mHVS54pnwwnDS0b67iJbr+t4j5F4HRyJSTOHw@mail.gmail.com>
 <20231204091334.GM3818@noisy.programming.kicks-ass.net>
 <20231204111128.GV8262@noisy.programming.kicks-ass.net>
 <20231204125239.GA1319@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204125239.GA1319@noisy.programming.kicks-ass.net>

On Mon, Dec 04, 2023 at 01:52:39PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 04, 2023 at 12:11:28PM +0100, Peter Zijlstra wrote:
> > On Mon, Dec 04, 2023 at 10:13:34AM +0100, Peter Zijlstra wrote:
> > 
> > > > Just running test_progs it splats right away:
> > > > 
> > > > [   74.047757] kmemleak: Found object by alias at 0xffffffffa0001d80
> > > > [   74.048272] CPU: 14 PID: 104 Comm: kworker/14:0 Tainted: G        W
> > > >  O       6.7.0-rc3-00702-g41c30fec304d-dirty #5241
> > > > [   74.049118] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > > BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > > > [   74.050042] Workqueue: events bpf_prog_free_deferred
> > > > [   74.050448] Call Trace:
> > > > [   74.050663]  <TASK>
> > > > [   74.050841]  dump_stack_lvl+0x55/0x80
> > > > [   74.051141]  __find_and_remove_object+0xdb/0x110
> > > > [   74.051521]  kmemleak_free+0x41/0x70
> > > > [   74.051828]  vfree+0x36/0x130
> > > 
> > > Durr, I'll see if I can get that stuff running locally, and otherwise
> > > play with the robot as you suggested. Thanks!
> > 
> > I think it is bpf_jit_binary_pack_hdr(), which is using prog->bpf_func
> > as a start address for the image, instead of jit_data->image.
> > 
> > This used to be true, but now it's offset.
> > 
> > Let me see what to do about that...
> 
> Not the prettiest of things, but the below seems to make the thing
> happy...
> 

hyea,
that boots properly for me but gives crash below when running bpf tests

jirka


---
[  482.145182][  T699] RIP: 0010:bpf_for_each_array_elem+0xbb/0x120
[  482.145672][  T699] Code: 4c 01 f5 89 5c 24 04 4c 89 e7 48 8d 74 24 04 48 89 ea 4c 89 fd 4c 89 f9 45 31 c0 4d 89 eb 41 ba ef 86 cd 67 45 03 53 f1 74 02 <0f> 0b 41 ff d3 0f 1f 00 48 85 c0 75 0e 48 8d 43 01 41 8b 4c 24 24
[  482.147221][  T699] RSP: 0018:ffffc900017e3e88 EFLAGS: 00010217
[  482.147702][  T699] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc900017e3ed8
[  482.152162][  T699] RDX: ffff888152eb0210 RSI: ffffc900017e3e8c RDI: ffff888152eb0000
[  482.152770][  T699] RBP: ffffc900017e3ed8 R08: 0000000000000000 R09: 0000000000000000
[  482.153350][  T699] R10: 000000004704ef28 R11: ffffffffa0012774 R12: ffff888152eb0000
[  482.153951][  T699] R13: ffffffffa0012774 R14: ffff888152eb0210 R15: ffffc900017e3ed8
[  482.154554][  T699] FS:  00007fa60d4fdd00(0000) GS:ffff88846d200000(0000) knlGS:0000000000000000
[  482.155138][  T699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  482.155564][  T699] CR2: 00007fa60d7d8000 CR3: 00000001502a2005 CR4: 0000000000770ef0
[  482.156095][  T699] PKRU: 55555554
[  482.156349][  T699] Call Trace:
[  482.156596][  T699]  <TASK>
[  482.156816][  T699]  ? __die_body+0x68/0xb0
[  482.157138][  T699]  ? die+0xba/0xe0
[  482.157456][  T699]  ? do_trap+0xa5/0x180
[  482.157826][  T699]  ? bpf_for_each_array_elem+0xbb/0x120
[  482.158277][  T699]  ? bpf_for_each_array_elem+0xbb/0x120
[  482.158711][  T699]  ? do_error_trap+0xc4/0x140
[  482.159052][  T699]  ? bpf_for_each_array_elem+0xbb/0x120
[  482.159506][  T699]  ? handle_invalid_op+0x2c/0x40
[  482.159906][  T699]  ? bpf_for_each_array_elem+0xbb/0x120
[  482.160990][  T699]  ? exc_invalid_op+0x38/0x60
[  482.161375][  T699]  ? asm_exc_invalid_op+0x1a/0x20
[  482.161788][  T699]  ? 0xffffffffa0012774
[  482.162149][  T699]  ? 0xffffffffa0012774
[  482.162513][  T699]  ? bpf_for_each_array_elem+0xbb/0x120
[  482.162905][  T699]  bpf_prog_ca45ea7f9cb8ac1a_inner_map+0x94/0x98
[  482.163471][  T699]  bpf_trampoline_6442549234+0x47/0x1000
[  482.163981][  T699]  __x64_sys_getpgid+0x9/0x20
[  482.164770][  T699]  do_syscall_64+0x53/0x110
[  482.165184][  T699]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  482.165646][  T699] RIP: 0033:0x7fa60d6c5b4d
[  482.166005][  T699] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 92 0c 00 f7 d8 64 89 01 48
[  482.169662][  T699] RSP: 002b:00007ffddfcf99e8 EFLAGS: 00000202 ORIG_RAX: 0000000000000079
[  482.170582][  T699] RAX: ffffffffffffffda RBX: 00007ffddfcf9d98 RCX: 00007fa60d6c5b4d
[  482.171376][  T699] RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000557baa5ab850
[  482.172010][  T699] RBP: 00007ffddfcf9b30 R08: 0000000000000000 R09: 0000000000000000
[  482.172665][  T699] R10: 0000000000000064 R11: 0000000000000202 R12: 0000000000000001
[  482.173359][  T699] R13: 0000000000000000 R14: 00007fa60d80d000 R15: 0000557ba6ab9790
[  482.174014][  T699]  </TASK>
[  482.174289][  T699] Modules linked in: bpf_testmod(OE) intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel kvm_intel rapl iTCO_wdt iTCO_vendor_support i2c_i801 i2c_smbus lpc_ich drm loop drm_panel_orientation_quirks zram
[  482.176040][  T699] ---[ end trace 0000000000000000 ]---
[  482.176534][  T699] RIP: 0010:bpf_for_each_array_elem+0xbb/0x120
[  482.177215][  T699] Code: 4c 01 f5 89 5c 24 04 4c 89 e7 48 8d 74 24 04 48 89 ea 4c 89 fd 4c 89 f9 45 31 c0 4d 89 eb 41 ba ef 86 cd 67 45 03 53 f1 74 02 <0f> 0b 41 ff d3 0f 1f 00 48 85 c0 75 0e 48 8d 43 01 41 8b 4c 24 24
[  482.179405][  T699] RSP: 0018:ffffc900017e3e88 EFLAGS: 00010217
[  482.179971][  T699] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc900017e3ed8
[  482.180615][  T699] RDX: ffff888152eb0210 RSI: ffffc900017e3e8c RDI: ffff888152eb0000
[  482.181195][  T699] RBP: ffffc900017e3ed8 R08: 0000000000000000 R09: 0000000000000000
[  482.181805][  T699] R10: 000000004704ef28 R11: ffffffffa0012774 R12: ffff888152eb0000
[  482.182411][  T699] R13: ffffffffa0012774 R14: ffff888152eb0210 R15: ffffc900017e3ed8
[  482.183043][  T699] FS:  00007fa60d4fdd00(0000) GS:ffff88846d200000(0000) knlGS:0000000000000000
[  482.183753][  T699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  482.184361][  T699] CR2: 00007fa60d7d8000 CR3: 00000001502a2005 CR4: 0000000000770ef0
[  482.185649][  T699] PKRU: 55555554
[  482.185985][  T699] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
[  482.186846][  T699] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 699, name: test_progs
[  482.187590][  T699] preempt_count: 0, expected: 0
[  482.188055][  T699] RCU nest depth: 1, expected: 0
[  482.188460][  T699] INFO: lockdep is turned off.
[  482.188861][  T699] CPU: 1 PID: 699 Comm: test_progs Tainted: G      D    OE      6.7.0-rc3+ #118 bfe8e46ac948d811e03ae3149ad95ea179efe638
[  482.189821][  T699] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
[  482.191140][  T699] Call Trace:
[  482.191469][  T699]  <TASK>
[  482.191766][  T699]  dump_stack_lvl+0xbd/0x120
[  482.192222][  T699]  __might_resched+0x24a/0x280
[  482.192694][  T699]  exit_signals+0x31/0x280
[  482.193123][  T699]  do_exit+0x1a6/0xbb0
[  482.193511][  T699]  ? bpf_trampoline_6442549234+0x47/0x1000
[  482.194025][  T699]  make_task_dead+0x94/0x180
[  482.194469][  T699]  rewind_stack_and_make_dead+0x17/0x20
[  482.194968][  T699] RIP: 0033:0x7fa60d6c5b4d
[  482.195399][  T699] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 92 0c 00 f7 d8 64 89 01 48
[  482.197082][  T699] RSP: 002b:00007ffddfcf99e8 EFLAGS: 00000202 ORIG_RAX: 0000000000000079
[  482.197887][  T699] RAX: ffffffffffffffda RBX: 00007ffddfcf9d98 RCX: 00007fa60d6c5b4d
[  482.198604][  T699] RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000557baa5ab850
[  482.199327][  T699] RBP: 00007ffddfcf9b30 R08: 0000000000000000 R09: 0000000000000000
[  482.200035][  T699] R10: 0000000000000064 R11: 0000000000000202 R12: 0000000000000001
[  482.200765][  T699] R13: 0000000000000000 R14: 00007fa60d80d000 R15: 0000557ba6ab9790
[  482.201499][  T699]  </TASK>

