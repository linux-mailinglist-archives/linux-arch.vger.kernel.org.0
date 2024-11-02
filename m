Return-Path: <linux-arch+bounces-8772-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A676C9B9D8F
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 08:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5D31C21988
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 07:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81700158535;
	Sat,  2 Nov 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyT3k4zB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F354156F5E;
	Sat,  2 Nov 2024 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730531310; cv=none; b=F3BIMhqgUdtkwaUwKtYcdRQF66c909kEG7JegTu/D+EGnuj2aZSJ4WaHGtkKN3sQ3aMhbKD0FdJ90I8+wgsx8rNo2rS8wtFPGy9wvKJo3VJPE+oiWERo26PCRM3IHA7r26d4odRTP6xgNExHvm8WQum/0m06YKbpyLF2B7k90hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730531310; c=relaxed/simple;
	bh=kXMw8nXdTzh+5/TW0jzALf0sAcfEu/eK7OpnnWpYv/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jdw/9RiwD+3yIFgobkRRGuL0qQlsDvg3hqGr9a2OCr/i5FO+uUgB5Lg+Y4kPXmil5b6FVoo2RNGNF3+EaJqZM25x4rZ6BShio3Hzu1UBp3MlQ64sQJA/NILxBofJmDc+otJR7r6B5FBw1+i61+qwEuqpxxDSTYKaTRSFfwAdObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyT3k4zB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730531309; x=1762067309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kXMw8nXdTzh+5/TW0jzALf0sAcfEu/eK7OpnnWpYv/Y=;
  b=FyT3k4zBvgJNmsNN1T+Iy0nTn/epoZ32tl5nL+eZHs/9Fd5ZEBOZ01bF
   A1MEiTgids/2f+iio7QDyhL15nYdakEM+ypiAamNeWeX6bg0AXDmA5S4l
   B1bwsr3TVl51hvz/Q3Mf0Kr4hI26NGv4T1VVo+D+GNK6tCIiOldKwgD6W
   5eZsOaU3u3ruMmu1M7s8vVv73HRz+3e2BPjdgm3Y4uGJaY2JxuNmO8LjL
   +ShnGYGlrzDuM4vfhVP7pFofry9compcq1JKQRaDQsaVUAx0l17CL8ZmW
   InVoJfwCdaCfWmcO0fMqMhn44jn0HyJuAyYmbVx+NiKDyswr0dPt87bDK
   A==;
X-CSE-ConnectionGUID: PU9bm6W7TKi6lUEApAP+gA==
X-CSE-MsgGUID: WfN7foQLQLiP5bQ4YDIgig==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30476049"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30476049"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 00:08:28 -0700
X-CSE-ConnectionGUID: ZvuMZxJSQPWa9EjT1rIthQ==
X-CSE-MsgGUID: 4m6SlXJwTuiw/LQreG7Obg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87930409"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 02 Nov 2024 00:08:21 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t78F7-000iXl-2Q;
	Sat, 02 Nov 2024 07:08:17 +0000
Date: Sat, 2 Nov 2024 15:07:54 +0800
From: kernel test robot <lkp@intel.com>
To: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v12 3/5] rust: samples: add tracepoint to Rust sample
Message-ID: <202411021421.jZ0FSDq6-lkp@intel.com>
References: <20241030-tracepoint-v12-3-eec7f0f8ad22@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-tracepoint-v12-3-eec7f0f8ad22@google.com>

Hi Alice,

kernel test robot noticed the following build errors:

[auto build test ERROR on eb887c4567d1b0e7684c026fe7df44afa96589e6]

url:    https://github.com/intel-lab-lkp/linux/commits/Alice-Ryhl/rust-add-static_branch_unlikely-for-static_key_false/20241031-000709
base:   eb887c4567d1b0e7684c026fe7df44afa96589e6
patch link:    https://lore.kernel.org/r/20241030-tracepoint-v12-3-eec7f0f8ad22%40google.com
patch subject: [PATCH v12 3/5] rust: samples: add tracepoint to Rust sample
config: x86_64-randconfig-103-20241101 (https://download.01.org/0day-ci/archive/20241102/202411021421.jZ0FSDq6-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411021421.jZ0FSDq6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411021421.jZ0FSDq6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find value `__tracepoint_rust_sample_loaded` in crate `$crate::bindings`
   --> samples/rust/rust_print.rs:87:5
   |
   87 | /     kernel::declare_trace! {
   88 | |         /// # Safety
   89 | |         ///
   90 | |         /// Always safe to call.
   91 | |         unsafe fn rust_sample_loaded(magic: c_int);
   92 | |     }
   | |_____^ not found in `$crate::bindings`
   |
   = note: this error originates in the macro `kernel::declare_trace` (in Nightly builds, run with -Z macro-backtrace for more info)
--
>> error[E0425]: cannot find function `rust_do_trace_rust_sample_loaded` in crate `$crate::bindings`
   --> samples/rust/rust_print.rs:87:5
   |
   87 | /     kernel::declare_trace! {
   88 | |         /// # Safety
   89 | |         ///
   90 | |         /// Always safe to call.
   91 | |         unsafe fn rust_sample_loaded(magic: c_int);
   92 | |     }
   | |_____^ not found in `$crate::bindings`
   |
   = note: this error originates in the macro `kernel::declare_trace` (in Nightly builds, run with -Z macro-backtrace for more info)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

