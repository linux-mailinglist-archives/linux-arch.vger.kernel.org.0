Return-Path: <linux-arch+bounces-1371-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6063782D7EF
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 12:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176001F22279
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4778C1E865;
	Mon, 15 Jan 2024 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b9q0o4tQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E522C683;
	Mon, 15 Jan 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D5A1440E01A9;
	Mon, 15 Jan 2024 11:00:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sfiRGpzfaODp; Mon, 15 Jan 2024 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705316423; bh=oP77XyZj9HhicA6zK+E2uirUhsgRReQ/mwWlYJegOQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9q0o4tQ50g+7Sr5DKT5AfeuDncxgpLRIIudonC6h0msPRkM2sMP9vfEa+BuCZbl1
	 Uqte3mOzZ+IpLU3RpLCzC92861U8l/LPzTnMMy+hXGuck4FLADjlPxWUXGi9TX58Sa
	 ysB5lW8rptHc7ilcZGNrQt29I8S59GnvuP2RDdAgJyOl4KXT8oAlwcXNxsvFdSuuZW
	 c0hLIp6HwzsEe6sFYqF/yeglM0EPf+m2FmVvCmEkarZH1Oti1fjhPfEap9JSNdQryq
	 7Btd8LUDHVJ/vxXOTnidM6NyotTX50FuXaHub7bKxt7VwPqfjS6irr6TxnouG1KufG
	 4BVKfTLTqr73UuSvSrZbaO/gMA5hlhZWIqHPvV2GtBuHzoovogDt0JcOwlDkbmWjFJ
	 oLKRKGMSUy5l/1A5ReOZId7WfIjRnEuQykO4K/9d57TvWCON/BAlGvRX1O/IF+ak/x
	 ijvYQidLBTIAmKJK7aKKLCiIOR9Zau8RftkXynt+Uk1yQrHEkzjH3HSR06A3xHKPaf
	 67x4l5jVNR9iJzhPeorcAEWYwPfx8VWHkauCWe2Zd04ccFdd5M5pY1D8NtkY+ssykL
	 ko4wsKO98DMsDEu/qo8GAu9HDua195gnEZgQd2RAlbTltZIxzksvnR2fT0ljic0SEu
	 Fk8eYp/HJEpH1SwTYxISl7RI=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C6BE40E016C;
	Mon, 15 Jan 2024 11:00:01 +0000 (UTC)
Date: Mon, 15 Jan 2024 12:00:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, nathan@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, bhelgaas@google.com, arnd@arndb.de,
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, javierm@redhat.com,
	linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 0/4] arch/x86: Remove unnecessary dependencies on
 bootparam.h
Message-ID: <20240115110000.GEZaUQMBwGAibwR_Yp@fat_crate.local>
References: <20240112095000.8952-1-tzimmermann@suse.de>
 <CAMj1kXGxNTvCca+9TfUfvp06ppyD9XiyO59khYXg88VkyFm1rw@mail.gmail.com>
 <3e2f70ab-c4de-4fae-9365-4f6f77c847c5@suse.de>
 <CAMj1kXGECo1E1U8jjrzvA=ZJe80DVOi3v5CvxkhXbnBQKVMT8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGECo1E1U8jjrzvA=ZJe80DVOi3v5CvxkhXbnBQKVMT8Q@mail.gmail.com>

On Mon, Jan 15, 2024 at 11:55:36AM +0100, Ard Biesheuvel wrote:
> But please be aware that we are in the middle of the merge window

Yes, and the merge window has been suspended too:

https://lore.kernel.org/r/CAHk-=wjMWpmXtKeiN__vnNO4TcttZR-8dVvd_oBq%2BhjeSsWUwg@mail.gmail.com

> right now, and I suspect that the -tip maintainers may have some
> feedback of their own. So give it at least a week or so, and ping this
> thread again to ask how to proceed.

From: Documentation/process/maintainer-tip.rst

"Merge window
^^^^^^^^^^^^

Please do not expect large patch series to be handled during the merge
window or even during the week before.  Such patches should be submitted in
mergeable state *at* *least* a week before the merge window opens.
Exceptions are made for bug fixes and *sometimes* for small standalone
drivers for new hardware or minimally invasive patches for hardware
enablement.

During the merge window, the maintainers instead focus on following the
upstream changes, fixing merge window fallout, collecting bug fixes, and
allowing themselves a breath. Please respect that.

The release candidate -rc1 is the starting point for new patches to be
applied which are targeted for the next merge window."

So pls be patient.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

