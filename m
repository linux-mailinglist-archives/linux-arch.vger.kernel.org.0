Return-Path: <linux-arch+bounces-7960-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555E9984AD
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 13:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014F91F255CF
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DCD1BFDE2;
	Thu, 10 Oct 2024 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayEqMonA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3079F33CD2;
	Thu, 10 Oct 2024 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559071; cv=none; b=sc2UuwIleC1mjednDiMKSvXOxbmGCUmXCNJhmA/lslVmu+zyRRqjUPXVBQ++rOiDI4sG5L9qUiy5Pw9IDSITNbOFbrXG/7Pe1j4g0vjTC2U/g4a9s6Hck5rE57C/fvFJXdeeIYWcc9jqPmeKlrncAsWx9PW3wiY/G2LNjw6NdA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559071; c=relaxed/simple;
	bh=VWRIjUC3AEIXbmmC2dLGoTxWtP6sLGoBUrTQ2GpoHHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaLp2NZ9dz0FPXmli0CxOUUYOnyLdQn7JmytZC/x6p3aqMGTAVbLtFzxCXPQtzGDkBnka4FBhvq5uotJNODUH9ZLtyiKBvk15Uc7sdPPauVQHJPbeAIK1ahQryyLIxlg4+G3706HUGXqj/UqgkJnYOLHuSjTE35nHZjtb4lZ51U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayEqMonA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728559070; x=1760095070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VWRIjUC3AEIXbmmC2dLGoTxWtP6sLGoBUrTQ2GpoHHg=;
  b=ayEqMonAU2drynTOSyioIdRISbBPF71dr3XNHqsgx1tMdvQadtpbe4cS
   oBTs1YXZIc/jFTnZyViOjzoTQkM+lSp6lmb1vnOEmp1CNBC3brGWUjZ05
   FFV1J8VMRxnpopTy7MT0Cf0E382wOH6KZDCGTuMQ30A2E06/m5YlAHX0A
   y3U0cKgcfJgbLIJpA38/wsyASiArxGzKHLI6Dj4dq/t5VMtET2RJHZ4Sf
   r4fSXLpzhbGzxdN8X52D3EGGpqrYK1NgNiW01Jqldl73y4V6vre62xu+1
   PR2VJwtXY7+YlGLiaqxNMVsE0lOmIZdvBDOz41iUuJFaUSs+SY9TQ/KH2
   w==;
X-CSE-ConnectionGUID: SwstaPzmQwarBWWyK2MzxA==
X-CSE-MsgGUID: 7jSjW4obQaq+N6ZqomCDKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="45423627"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="45423627"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:17:48 -0700
X-CSE-ConnectionGUID: eVCX4pvRSYinHoImS686yg==
X-CSE-MsgGUID: GLTvq/yvSi+v/PlKfKjrrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="76877392"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:17:35 -0700
Date: Thu, 10 Oct 2024 19:16:37 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>, yi1.lai@intel.com
Subject: Re: [PATCH net-next v25 10/13] net: add SO_DEVMEM_DONTNEED
 setsockopt to release RX frags
Message-ID: <Zwe3lWTN36IUaIdd@ly-workstation>
References: <20240909054318.1809580-1-almasrymina@google.com>
 <20240909054318.1809580-11-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909054318.1809580-11-almasrymina@google.com>

Hi Mina Almasry,

Greetings!

I used Syzkaller and found that there is BUG: soft lockup inqt in linux-next tree next-20241008

After bisection and the first bad commit is:
"
678f6e28b5f6 net: add SO_DEVMEM_DONTNEED setsockopt to release RX frags
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/241009_103423_do_sock_setsockopt
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/241009_103423_do_sock_setsockopt/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/241009_103423_do_sock_setsockopt/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/241009_103423_do_sock_setsockopt/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/241009_103423_do_sock_setsockopt/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/241009_103423_do_sock_setsockopt/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241009_103423_do_sock_setsockopt/bzImage_8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/241009_103423_do_sock_setsockopt/8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b_dmesg.log

"
[   48.825073]  ? __lock_acquire+0x1b0f/0x5c90
[   48.825419]  ? __pfx___lock_acquire+0x10/0x10
[   48.825774]  sock_setsockopt+0x68/0x90
[   48.826117]  do_sock_setsockopt+0x3fb/0x480
[   48.826455]  ? __pfx_do_sock_setsockopt+0x10/0x10
[   48.826829]  ? lock_release+0x441/0x870
[   48.827140]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   48.827558]  ? fdget+0x188/0x230
[   48.827846]  __sys_setsockopt+0x131/0x200
[   48.828184]  ? __pfx___sys_setsockopt+0x10/0x10
[   48.828551]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   48.829042]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   48.829425]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
[   48.829817]  __x64_sys_setsockopt+0xc6/0x160
[   48.830160]  ? syscall_trace_enter+0x14a/0x230
[   48.830520]  x64_sys_call+0x6cf/0x20d0
[   48.830825]  do_syscall_64+0x6d/0x140
[   48.831124]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   48.831517] RIP: 0033:0x7f26cdc3ee5d
[   48.831804] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   48.833180] RSP: 002b:00007fff33f36278 EFLAGS: 00000213 ORIG_RAX: 0000000000000036
[   48.833756] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f26cdc3ee5d
[   48.834294] RDX: 0000000000000050 RSI: 0000000000000001 RDI: 0000000000000003
[   48.834830] RBP: 00007fff33f36290 R08: 0000000000000010 R09: 00007fff33f36290
[   48.835368] R10: 0000000020000080 R11: 0000000000000213 R12: 00007fff33f363e8
[   48.835906] R13: 000000000040178f R14: 0000000000403e08 R15: 00007f26cde51000
[   48.836466]  </TASK>
[   48.836648] Kernel panic - not syncing: softlockup: hung tasks
[   48.837096] CPU: 1 UID: 0 PID: 729 Comm: repro Tainted: G             L     6.12.0-rc2-8cf0b93919e1 #1
[   48.837796] Tainted: [L]=SOFTLOCKUP
[   48.838071] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   48.838916] Call Trace:
[   48.839113]  <IRQ>
[   48.839282]  dump_stack_lvl+0x42/0x150
[   48.839584]  dump_stack+0x19/0x20
[   48.839846]  panic+0x703/0x790
[   48.840100]  ? __pfx_panic+0x10/0x10
[   48.840394]  ? watchdog_timer_fn+0x599/0x6b0
[   48.840727]  ? watchdog_timer_fn+0x58c/0x6b0
[   48.841065]  watchdog_timer_fn+0x5aa/0x6b0
[   48.841382]  ? __pfx_watchdog_timer_fn+0x10/0x10
[   48.841743]  __hrtimer_run_queues+0x5d6/0xc30
[   48.842091]  ? __pfx___hrtimer_run_queues+0x10/0x10
[   48.842473]  hrtimer_interrupt+0x324/0x7a0
[   48.842802]  __sysvec_apic_timer_interrupt+0x10b/0x410
[   48.843198]  ? debug_smp_processor_id+0x20/0x30
[   48.843551]  sysvec_apic_timer_interrupt+0xaf/0xd0
[   48.843922]  </IRQ>
[   48.844101]  <TASK>
[   48.844275]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[   48.844711] RIP: 0010:__sanitizer_cov_trace_pc+0x45/0x70
[   48.845130] Code: a9 00 01 ff 00 74 1d f6 c4 01 74 43 a9 00 00 0f 00 75 3c a9 00 00 f0 00 75 35 8b 82 04 1e 00 00 85 c0 74 2b 8b 82 e0 1d 00 00 <83> f8 02 75 20 48 8b 8a e8 1d 00 00 8b 92 e4 1d 00 00 48 8b 01 48
[   48.846480] RSP: 0018:ffff8880239cf790 EFLAGS: 00000246
[   48.846876] RAX: 0000000000000000 RBX: ffff8880239cf900 RCX: ffffffff8581c19f
[   48.847407] RDX: ffff88801a818000 RSI: ffffffff8581c1d5 RDI: 0000000000000007
[   48.847933] RBP: ffff8880239cf790 R08: 0000000000000001 R09: ffffed1004739f23
[   48.848472] R10: 0000000077cc006e R11: 0000000000000001 R12: 0000000000000000
[   48.849002] R13: 0000000077cc006e R14: ffff8880239cf918 R15: 0000000000000000
[   48.849536]  ? xas_start+0x11f/0x730
[   48.849818]  ? xas_start+0x155/0x730
[   48.850101]  xas_start+0x155/0x730
[   48.850372]  xas_load+0x2f/0x520
[   48.850629]  ? irqentry_exit+0x3e/0xa0
[   48.850922]  ? sysvec_apic_timer_interrupt+0x6a/0xd0
[   48.851304]  xas_store+0x1165/0x1ad0
[   48.851588]  ? __this_cpu_preempt_check+0x21/0x30
[   48.851950]  ? irqentry_exit+0x3e/0xa0
[   48.852254]  __xa_erase+0xc6/0x180
[   48.852524]  ? __pfx___xa_erase+0x10/0x10
[   48.852842]  ? __xa_erase+0xf1/0x180
[   48.853123]  ? sock_devmem_dontneed+0x42c/0x6d0
[   48.853480]  sock_devmem_dontneed+0x3a8/0x6d0
[   48.853829]  ? __pfx_sock_devmem_dontneed+0x10/0x10
[   48.854205]  ? trace_lock_acquire+0x139/0x1b0
[   48.854548]  ? lock_acquire+0x80/0xb0
[   48.854833]  ? __might_fault+0xf1/0x1b0
[   48.855133]  ? __might_fault+0xf1/0x1b0
[   48.855437]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   48.855849]  sk_setsockopt+0x480/0x3c60
[   48.856158]  ? __pfx_sk_setsockopt+0x10/0x10
[   48.856491]  ? __kasan_check_read+0x15/0x20
[   48.856814]  ? __lock_acquire+0x1b0f/0x5c90
[   48.857144]  ? __pfx___lock_acquire+0x10/0x10
[   48.857488]  sock_setsockopt+0x68/0x90
[   48.857785]  do_sock_setsockopt+0x3fb/0x480
[   48.858110]  ? __pfx_do_sock_setsockopt+0x10/0x10
[   48.858474]  ? lock_release+0x441/0x870
[   48.858776]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   48.859184]  ? fdget+0x188/0x230
[   48.859448]  __sys_setsockopt+0x131/0x200
[   48.859764]  ? __pfx___sys_setsockopt+0x10/0x10
[   48.860123]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   48.860598]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   48.860982]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
[   48.861370]  __x64_sys_setsockopt+0xc6/0x160
[   48.861710]  ? syscall_trace_enter+0x14a/0x230
[   48.862057]  x64_sys_call+0x6cf/0x20d0
[   48.862350]  do_syscall_64+0x6d/0x140
[   48.862639]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   48.863023] RIP: 0033:0x7f26cdc3ee5d
[   48.863301] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   48.864659] RSP: 002b:00007fff33f36278 EFLAGS: 00000213 ORIG_RAX: 0000000000000036
[   48.865223] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f26cdc3ee5d
"

I hope you find it useful.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

On Mon, Sep 09, 2024 at 05:43:15AM +0000, Mina Almasry wrote:
> Add an interface for the user to notify the kernel that it is done
> reading the devmem dmabuf frags returned as cmsg. The kernel will
> drop the reference on the frags to make them available for reuse.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> ---
> 
> v16:
> - Use sk_is_tcp().
> - Fix unnamed 128 DONTNEED limit (David).
> - Fix kernel allocating for 128 tokens even if the user didn't ask for
>   that much (Eric).
> - Fix number assignement (Arnd).
> 
> v10:
> - Fix leak of tokens (Nikolay).
> 
> v7:
> - Updated SO_DEVMEM_* uapi to use the next available entry (Arnd).
> 
> v6:
> - Squash in locking optimizations from edumazet@google.com. With his
>   changes we lock the xarray once per sock_devmem_dontneed operation
>   rather than once per frag.
> 
> Changes in v1:
> - devmemtoken -> dmabuf_token (David).
> - Use napi_pp_put_page() for refcounting (Yunsheng).
> - Fix build error with missing socket options on other asms.
> 
> ---
>  arch/alpha/include/uapi/asm/socket.h  |  1 +
>  arch/mips/include/uapi/asm/socket.h   |  1 +
>  arch/parisc/include/uapi/asm/socket.h |  1 +
>  arch/sparc/include/uapi/asm/socket.h  |  1 +
>  include/uapi/asm-generic/socket.h     |  1 +
>  include/uapi/linux/uio.h              |  4 ++
>  net/core/sock.c                       | 68 +++++++++++++++++++++++++++
>  7 files changed, 77 insertions(+)
> 
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index ef4656a41058..251b73c5481e 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -144,6 +144,7 @@
>  #define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
>  #define SO_DEVMEM_DMABUF	79
>  #define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
> +#define SO_DEVMEM_DONTNEED	80
>  
>  #if !defined(__KERNEL__)
>  
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
> index 414807d55e33..8ab7582291ab 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -155,6 +155,7 @@
>  #define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
>  #define SO_DEVMEM_DMABUF	79
>  #define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
> +#define SO_DEVMEM_DONTNEED	80
>  
>  #if !defined(__KERNEL__)
>  
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
> index 2b817efd4544..38fc0b188e08 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -136,6 +136,7 @@
>  #define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
>  #define SO_DEVMEM_DMABUF	79
>  #define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
> +#define SO_DEVMEM_DONTNEED	80
>  
>  #if !defined(__KERNEL__)
>  
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
> index 00248fc68977..57084ed2f3c4 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -137,6 +137,7 @@
>  #define SCM_DEVMEM_LINEAR        SO_DEVMEM_LINEAR
>  #define SO_DEVMEM_DMABUF         0x0058
>  #define SCM_DEVMEM_DMABUF        SO_DEVMEM_DMABUF
> +#define SO_DEVMEM_DONTNEED       0x0059
>  
>  #if !defined(__KERNEL__)
>  
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index e993edc9c0ee..3b4e3e815602 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -139,6 +139,7 @@
>  #define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
>  #define SO_DEVMEM_DMABUF	79
>  #define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
> +#define SO_DEVMEM_DONTNEED	80
>  
>  #if !defined(__KERNEL__)
>  
> diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
> index 3a22ddae376a..d17f8fcd93ec 100644
> --- a/include/uapi/linux/uio.h
> +++ b/include/uapi/linux/uio.h
> @@ -33,6 +33,10 @@ struct dmabuf_cmsg {
>  				 */
>  };
>  
> +struct dmabuf_token {
> +	__u32 token_start;
> +	__u32 token_count;
> +};
>  /*
>   *	UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
>   */
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 468b1239606c..bbb57b5af0b1 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -124,6 +124,7 @@
>  #include <linux/netdevice.h>
>  #include <net/protocol.h>
>  #include <linux/skbuff.h>
> +#include <linux/skbuff_ref.h>
>  #include <net/net_namespace.h>
>  #include <net/request_sock.h>
>  #include <net/sock.h>
> @@ -1049,6 +1050,69 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PAGE_POOL
> +
> +/* This is the number of tokens that the user can SO_DEVMEM_DONTNEED in
> + * 1 syscall. The limit exists to limit the amount of memory the kernel
> + * allocates to copy these tokens.
> + */
> +#define MAX_DONTNEED_TOKENS 128
> +
> +static noinline_for_stack int
> +sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> +{
> +	unsigned int num_tokens, i, j, k, netmem_num = 0;
> +	struct dmabuf_token *tokens;
> +	netmem_ref netmems[16];
> +	int ret = 0;
> +
> +	if (!sk_is_tcp(sk))
> +		return -EBADF;
> +
> +	if (optlen % sizeof(struct dmabuf_token) ||
> +	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> +		return -EINVAL;
> +
> +	tokens = kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
> +	if (!tokens)
> +		return -ENOMEM;
> +
> +	num_tokens = optlen / sizeof(struct dmabuf_token);
> +	if (copy_from_sockptr(tokens, optval, optlen)) {
> +		kvfree(tokens);
> +		return -EFAULT;
> +	}
> +
> +	xa_lock_bh(&sk->sk_user_frags);
> +	for (i = 0; i < num_tokens; i++) {
> +		for (j = 0; j < tokens[i].token_count; j++) {
> +			netmem_ref netmem = (__force netmem_ref)__xa_erase(
> +				&sk->sk_user_frags, tokens[i].token_start + j);
> +
> +			if (netmem &&
> +			    !WARN_ON_ONCE(!netmem_is_net_iov(netmem))) {
> +				netmems[netmem_num++] = netmem;
> +				if (netmem_num == ARRAY_SIZE(netmems)) {
> +					xa_unlock_bh(&sk->sk_user_frags);
> +					for (k = 0; k < netmem_num; k++)
> +						WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> +					netmem_num = 0;
> +					xa_lock_bh(&sk->sk_user_frags);
> +				}
> +				ret++;
> +			}
> +		}
> +	}
> +
> +	xa_unlock_bh(&sk->sk_user_frags);
> +	for (k = 0; k < netmem_num; k++)
> +		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> +
> +	kvfree(tokens);
> +	return ret;
> +}
> +#endif
> +
>  void sockopt_lock_sock(struct sock *sk)
>  {
>  	/* When current->bpf_ctx is set, the setsockopt is called from
> @@ -1211,6 +1275,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  			ret = -EOPNOTSUPP;
>  		return ret;
>  		}
> +#ifdef CONFIG_PAGE_POOL
> +	case SO_DEVMEM_DONTNEED:
> +		return sock_devmem_dontneed(sk, optval, optlen);
> +#endif
>  	}
>  
>  	sockopt_lock_sock(sk);
> -- 
> 2.46.0.469.g59c65b2a67-goog
> 

