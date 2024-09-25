Return-Path: <linux-arch+bounces-7433-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A12D498663F
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 20:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEFE1F26BEF
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 18:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982E913AA38;
	Wed, 25 Sep 2024 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="ENf3gmdN"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5784A31;
	Wed, 25 Sep 2024 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288874; cv=none; b=C8n1nkcuuC8fhEYbYjZ1TjqgOeLK2/XYb3rNKQablIcwNnYBXaCKXvDdfPy68A2cDJaDt7xKL/yjPjT6oFnvYSyURlajyh0NTYVb6N7OboH3AOiFc8a40UhMYyakkqgUwb0f2G3WxOu+qp6Nco70kGKNV8C8/OXXs5Fuqn8cGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288874; c=relaxed/simple;
	bh=JzQWbfOrfYxZbx1u+F5TLFsCW+d1dC/t+zlnRXg1aTo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dDjYoniWrhoc7+6g86OgEF+M9xsu3H0e1ktE5s20ZRDBP89zQbn6n/WjPfqq8vzIjhYiST++3S8KP0heKjsb0al8sRYN/9KFOywwchRhB3BIdzZ6EVi1medLw+FBj0tLdHXCn5cQRHHWeO3lEdnu0HiiHvm0Kg0X7BHQPlYRrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=ENf3gmdN; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1727286998;
	bh=JzQWbfOrfYxZbx1u+F5TLFsCW+d1dC/t+zlnRXg1aTo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ENf3gmdNOzt5kB/scKgyNgokVg82OzC76ZN4/YF8VlUv1bRir3KWi37eV+i/D7Xez
	 Z5XbR4kUlSRyKbxlzzZRLBN7clHZ2LO2BU5gH0H7RQVCi6hfAu+SXyoqfJtQRocwP3
	 D9Ah5X6dCKhSwWEojhc0qMzPTKaZpdvB/V2zxYX8=
Received: by gentwo.org (Postfix, from userid 1003)
	id 70FD5401C7; Wed, 25 Sep 2024 10:56:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 6F6F0401C6;
	Wed, 25 Sep 2024 10:56:38 -0700 (PDT)
Date: Wed, 25 Sep 2024 10:56:38 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ard Biesheuvel <ardb+git@google.com>
cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, 
    Tejun Heo <tj@kernel.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Paolo Bonzini <pbonzini@redhat.com>, 
    Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
    Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, 
    Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
    Keith Packard <keithp@keithp.com>, Justin Stitt <justinstitt@google.com>, 
    Josh Poimboeuf <jpoimboe@kernel.org>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
    Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
    Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
    linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
    xen-devel@lists.xenproject.org, linux-efi@vger.kernel.org, 
    linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org, 
    linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org, 
    rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 06/28] x86/percpu: Get rid of absolute per-CPU variable
 placement
In-Reply-To: <20240925150059.3955569-36-ardb+git@google.com>
Message-ID: <c4bc67dd-2a42-b318-7830-6741e3579775@gentwo.org>
References: <20240925150059.3955569-30-ardb+git@google.com> <20240925150059.3955569-36-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 25 Sep 2024, Ard Biesheuvel wrote:

> The x86_64 approach was needed to accommodate per-task stack protector
> cookies, which used to live at a fixed offset of GS+40, requiring GS to
> be treated as a base register. This is no longer the case, though, and
> so GS can be repurposed as a true per-CPU offset, adopting the same
> strategy as other architectures.
>
> This also removes the need for linker tricks to emit the per-CPU ELF
> segment at a different virtual address. It also means RIP-relative
> per-CPU variables no longer need to be relocated in the opposite
> direction when KASLR is applied, which was necessary because the 0x0
> based per-CPU region remains in place even when the kernel is moved
> around.

Looks like a good cleanup. Hope it does not break anything that relies on
structures %GS points to.

Reviewed-by: Christoph Lameter <cl@linux.com>

