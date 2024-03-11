Return-Path: <linux-arch+bounces-2927-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E622B878589
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 17:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F4D1C21B26
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E10B3C482;
	Mon, 11 Mar 2024 16:34:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5317F138E;
	Mon, 11 Mar 2024 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174868; cv=none; b=I+3uuGsgLSOAOouTbufhyX+3njPNomwdBAO+bbZtlH3vtfxmIXDFLF6UlFQXdIi6H1T9XT9FPw4ebvV8xIywzRtEsrZ2FB6Tejr4iP7k/vn7F+gHYn6mUKb2DQVOHJZ2lMrZN//t4evkKn1d8u4eCt0oi1otJlwrXCNqeio0RQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174868; c=relaxed/simple;
	bh=WixOqrZR+rJh/Fbz+wWrf8dVTfQslX0GeSZNmY4xbK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=sgNdPA3bpwooKtZGLXUbTSNmXqj4NYWytNwjZUQIDTva+meTuCLnUzYVjFXodSXztS8aGozb4Svzws0v8wD6dL/4xi0A8goC6joZMPAl0oCS+EX+RbAjtZQ+SBGuR4Vd2G0MmRBSNWppn6rjs9aVJF+K2z5V6ENDfoIxYYUhL7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A7831007;
	Mon, 11 Mar 2024 09:35:02 -0700 (PDT)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D3233F762;
	Mon, 11 Mar 2024 09:34:12 -0700 (PDT)
Message-ID: <1ab20914-b6d2-fe39-7b14-c1ccebaa34f6@arm.com>
Date: Mon, 11 Mar 2024 16:34:10 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 12/13] tools headers: Sync compiler.h headers
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20240310020509.647319-1-irogers@google.com>
 <20240310020509.647319-13-irogers@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>,
 Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, "Michael S. Tsirkin"
 <mst@redhat.com>, Shunsuke Mie <mie@igel.co.jp>,
 Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>,
 Nick Forrington <nick.forrington@arm.com>, Leo Yan <leo.yan@linux.dev>,
 German Gomez <german.gomez@arm.com>, Rob Herring <robh@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Sean Christopherson
 <seanjc@google.com>, Anup Patel <anup@brainfault.org>,
 Fuad Tabba <tabba@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Haibo Xu <haibo1.xu@intel.com>,
 Peter Xu <peterx@redhat.com>, Vishal Annapurve <vannapurve@google.com>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240310020509.647319-13-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/03/2024 02:05, Ian Rogers wrote:
> compiler.h - synced from include/linux/compiler.h, guards were
>  added to definitions to avoid redefinition of macros
>  in libc. ftrace, CONFIG_OBJTOOL and kentry logic was removed as
>  redundant.
> 

Hi Ian,

This commit breaks the Arm build (and cross compilation for Arm on x86):

  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-

Something like this, but I won't paste the whole output because it's huge:

tools/include/linux/ring_buffer.h: In function ‘ring_buffer_read_head’:

tools/include/asm/../../arch/arm64/include/asm/barrier.h:72:35: error:
‘__u8_alias_t’ undeclared (first use in this function)
   72 |                         : "=r" (*(__u8_alias_t *)__u.__c)
       \
      |                                   ^~~~~~~~~~~~
tools/include/linux/ring_buffer.h:59:16: note: in expansion of macro
‘smp_load_acquire’
   59 |         return smp_load_acquire(&base->data_head);
      |                ^~~~~~~~~~~~~~~~

Thanks
James

