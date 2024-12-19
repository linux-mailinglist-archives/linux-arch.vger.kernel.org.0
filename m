Return-Path: <linux-arch+bounces-9431-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8039F7ABE
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 12:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EF9161F9C
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5423422370D;
	Thu, 19 Dec 2024 11:53:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A101223330;
	Thu, 19 Dec 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609208; cv=none; b=iXrBucITUBCsE2n5tbT59F/qFquEoluhOd4yqQVfgPm9iptiZ5OzsAcwQvjAu2Csk2pidURsXze9GjzZxNPn45tEjKN1l1h3xzjUjsszFCBUOGRI9Aouja4D2XhTJcdgyI4Es89RFqSyOjyPzYlBFvZsMKJ5uXKt6iCTEmATCXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609208; c=relaxed/simple;
	bh=7SYHZIs/WrMiFnJV+UNkilY+ZLz4Hxrf5N56/tTsSDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1mMaFYGchudiRdpSATSPBLucSshHkp8+k/jy5+rldeNyLU8/INF+CI0aCyKIyreEFsrunngBdSe2e1pFDcOnbli0R2XOJU3RsSw9Yi960YVMAdhyHUjhkb/atYPtn0R/pBZwjywQ0iSaHNf9N/tiCZRWaryb0TBxXyxgCKHCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C3EC1477;
	Thu, 19 Dec 2024 03:53:53 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4C173F720;
	Thu, 19 Dec 2024 03:53:19 -0800 (PST)
Date: Thu, 19 Dec 2024 11:53:13 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Keith Packard <keithp@keithp.com>,
	Justin Stitt <justinstitt@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-efi@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC PATCH 02/28] Documentation: Bump minimum GCC version to 8.1
Message-ID: <Z2QJKZBsgvPMgRo_@J2N7QTR9R3>
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-32-ardb+git@google.com>
 <c4868f63-b688-4489-a112-05bf04280bde@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4868f63-b688-4489-a112-05bf04280bde@app.fastmail.com>

Hi Arnd,

On Wed, Sep 25, 2024 at 03:58:38PM +0000, Arnd Bergmann wrote:
> On Wed, Sep 25, 2024, at 15:01, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Bump the minimum GCC version to 8.1 to gain unconditional support for
> > referring to the per-task stack cookie using a symbol rather than
> > relying on the fixed offset of 40 bytes from %GS, which requires
> > elaborate hacks to support.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  Documentation/admin-guide/README.rst | 2 +-
> >  Documentation/process/changes.rst    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> As we discussed during plumbers, I think this is reasonable,
> both the gcc-8.1 version and the timing after the 6.12-LTS
> kernel.
> 
> We obviously need to go through all the other version checks
> to see what else can be cleaned up. I would suggest we also
> raise the binutils version to 2.30+, which is what RHEL8
> shipped alongside gcc-8. I have not found other distros that
> use older binutils in combination with gcc-8 or higher,
> Debian 10 uses binutils-2.31.
> I don't think we want to combine the additional cleanup with
> your series, but if we can agree on the version, we can do that
> in parallel.

Were you planning to send patches to that effect, or did you want
someone else to do that? I think we were largely agreed on making those
changes, but it wasn't clear to me who was actually going to send
patches, and I couldn't spot a subsequent thread on LKML.

Mark.

