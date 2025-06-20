Return-Path: <linux-arch+bounces-12410-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A5AE10C4
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 03:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439DF3BCF3D
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 01:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D14482F2;
	Fri, 20 Jun 2025 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jM7li+nU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28D822339;
	Fri, 20 Jun 2025 01:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750383316; cv=none; b=R98PgGTdel6enioluMAYbvvSSvZ+wIiyUKbrXk4gJZ1TrMP/429A+S/Ogbp1y3l7D1DVdd06eLe/KrlMNIG6m36zfgzljIRaBCZze1ERE+lsVRNyEYLbzXP0/2QqT06QeZSa1q1whX+sYAtJF2/38Tdb2oAnNEbMVyOh7YOkTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750383316; c=relaxed/simple;
	bh=Ygb8D3DFDD//bZSNlotR+GYu4xbc8GQmhXzfNgEY/lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evf2vWN7P57iJcRB49CQ5Ogp+kbgW4Sm9KOkroJqIqdH4XQ+S7dj0YfBy9nMniTk7nKA41fgMYRyvgEvlm7KflPPr8QY1DytRNZDkS6/h+cm6zEl+Yc75COmz/1HIVn6BfB9M7dJmnbr2SSpejb2rVOlzE55d+OAT8hOQCucN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jM7li+nU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750383315; x=1781919315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ygb8D3DFDD//bZSNlotR+GYu4xbc8GQmhXzfNgEY/lU=;
  b=jM7li+nUUt/Qidl+PterMewp2En2Kw4LOW04OYx4WnCmn2JmlmZjJPul
   0lux5JQuGuOpiEm1F1URoZmaP7dWSd1EaM1CjX1levRGHazxzhb/G0xOd
   S7YXONf5s9wi/f3Xtfew7VeEhnVedk/X4lWvA8WX0k0vpahTklUZQ9ZHH
   HjYqvtYKxRYNtF0E3M71YO/kFDj3ePqQ3mUI+byNoG72cjnMG2tEuT+k8
   uxgbWDOikNSN/fOUI3iLUqaTk5sedHpgRpxGD69vuzzVP4mIiow2LDOMe
   2AS3uwffdnmqKsTVB4ba/9vOyEGPo3mk5UOgxxdxprGN4hcE4bamhKuyU
   Q==;
X-CSE-ConnectionGUID: q4cPJS7RTK+ev3X1XN6JWQ==
X-CSE-MsgGUID: XgOcd5gVQWOJLU80xbstpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51750452"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="51750452"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 18:35:14 -0700
X-CSE-ConnectionGUID: CPgJMUJiRxiT9t4/7rcsJg==
X-CSE-MsgGUID: kbMFDARYTOqnqEggcyM+9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="188001454"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Jun 2025 18:35:09 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSQep-000LGA-0S;
	Fri, 20 Jun 2025 01:35:07 +0000
Date: Fri, 20 Jun 2025 09:34:12 +0800
From: kernel test robot <lkp@intel.com>
To: Alice Ryhl <aliceryhl@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-hardening@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH] panic: improve panic output from Rust panics
Message-ID: <202506200907.0hDFXWmf-lkp@intel.com>
References: <20250619-rust-panic-v1-1-ad1a803962e5@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-rust-panic-v1-1-ad1a803962e5@google.com>

Hi Alice,

kernel test robot noticed the following build errors:

[auto build test ERROR on 19272b37aa4f83ca52bdf9c16d5d81bdd1354494]

url:    https://github.com/intel-lab-lkp/linux/commits/Alice-Ryhl/panic-improve-panic-output-from-Rust-panics/20250619-231923
base:   19272b37aa4f83ca52bdf9c16d5d81bdd1354494
patch link:    https://lore.kernel.org/r/20250619-rust-panic-v1-1-ad1a803962e5%40google.com
patch subject: [PATCH] panic: improve panic output from Rust panics
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250620/202506200907.0hDFXWmf-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250620/202506200907.0hDFXWmf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506200907.0hDFXWmf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0277]: `core::option::Option<&core::fmt::Arguments<'_>>` doesn't implement `core::fmt::Display`
   --> rust/kernel/lib.rs:210:36
   |
   210 |     match core::format_args!("{}", info.message()) {
   |                                    ^^^^^^^^^^^^^^ `core::option::Option<&core::fmt::Arguments<'_>>` cannot be formatted with the default formatter
   |
   = help: the trait `core::fmt::Display` is not implemented for `core::option::Option<&core::fmt::Arguments<'_>>`
   = note: in format strings you may be able to use `{:?}` (or {:#?} for pretty-print) instead
   = note: this error originates in the macro `core::format_args` (in Nightly builds, run with -Z macro-backtrace for more info)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

