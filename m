Return-Path: <linux-arch+bounces-10925-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE20A670A4
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 11:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 195587A31F4
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9869F2080CD;
	Tue, 18 Mar 2025 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WvVnHM5g"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F0207667;
	Tue, 18 Mar 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292005; cv=none; b=jj1qitwNReZtSKSHAUfYMOiRBhkVTfpUbG5LfJUDsk28Z/wTEzHmhtPDUsRkWCHcek/qfb3D7Fqus6ZJtnoAVtT/iYHQ0Fju5d2dThfA8w3UKu9xEoQIqz9T3mv6yn+U/W9tXUaJmT0w/8kOSS6VC187KNBasCzAy5HZZr37VRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292005; c=relaxed/simple;
	bh=vJv1KkdXbPcvAghM29T8PsBL8Lb4ASjOFhvS2uQ91tE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pbET7aaDOZVBn1m6787sRR6qZKPSO2xUD/2vXV/ISz2Ab9Ap0DXFnzQ+xHCYKD8rXya4kV9/nEraB1IqvzPSMfuNEM0rvxdYm0j5XSEB4yPtslIBmMLSLHyWyyoOSi6/ewnI1yQAP0QH5CQN5D+BHS8J7pLKnHwFnrgUzhx0Rdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WvVnHM5g; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vJv1KkdXbPcvAghM29T8PsBL8Lb4ASjOFhvS2uQ91tE=;
	t=1742292004; x=1743501604; b=WvVnHM5gN2mh20b4ydGc3t/AKz0KrOgl1NTaVmS8kZ+JS8k
	V+Ql6nFvWbdamRIROixnwDQgOKJo1j4KAlkHZiKCKvuQUrPeUKhdsGvH7vHuNGNjy9D7ilCHqB3+V
	3FKvmAOqZpg9Pph4hl2CovMxVDOc85jJYgSvEfD76cp36vJC2+u/b2RERfaJL8/1XXCWmE5r6lFVf
	HXwKOFxIEdHLGuIkvfgtUqailHJWAhB10/UzEoKli1Z4w0vHpXTB9MWa/eH+Nm0cjo0ffVP/kqJuv
	LzqPzkov2dkvnKdhMGgok3AE1Fkt/pLZDVoHK5pPHPUuEN9LcX0/Y+YWvKA4SvgA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tuTjs-0000000FCgD-2h9m;
	Tue, 18 Mar 2025 11:00:00 +0100
Message-ID: <45e2f8f566539a766bc7e089e71211e320bc4fa6.camel@sipsolutions.net>
Subject: Re: [PATCH 35/41] um: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 the usermode headers
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, 	linux-um@lists.infradead.org
Date: Tue, 18 Mar 2025 10:59:59 +0100
In-Reply-To: <20250314071013.1575167-36-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
	 <20250314071013.1575167-36-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-03-14 at 08:10 +0100, Thomas Huth wrote:
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, so let's standardize on the __ASSEMBLER__
> macro that is provided by the compilers now.
>=20
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).
>=20

Looks fine, I guess - I'll assume that since it's part of a larger
series you'll merge it elsewhere.

johannes

