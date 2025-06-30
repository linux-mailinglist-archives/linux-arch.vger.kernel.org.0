Return-Path: <linux-arch+bounces-12508-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA3BAEDA37
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 12:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564B57A1BFE
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69F420E032;
	Mon, 30 Jun 2025 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="c7zuP1pY"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4BA84A2B;
	Mon, 30 Jun 2025 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280350; cv=none; b=HV2Mu6/KZGtLMBMxef13KnhjaYQQhR2juKSzfZtly3C+gbaeAlufR2ZU0jSFu3WFjkWcNR+p+VIjEXr5lKpTsAWMpekisNPbGkMMhzaoynx59zXMRorCqe+0pZFieHFqAW37XnBp9c7Gl6G7hgbMXBitvHdhlN+ZclvN8QoEr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280350; c=relaxed/simple;
	bh=1qYyqEbzXKw1kYwIHnancyXtFBiFkWq5bCUGJRFKZSs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ttk2h/F+/vBYSI4JkDLwtKFI1Y2mhFPRjjpmW9LkUjS/2ZSSXJoX9yXkV1gGr9LqfiQ/Iov/lMExxttH6gti2BXujih77Ug4fdGI1WLsGQ3s4jP/E04xvKsccfE305TlfxCRoy2mGiFvDMqzd1wc+IBz3HXWwhQxk+VKH0ShudI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=c7zuP1pY; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RG0EfRjcxYEAjzaFRWe/5+PpKyJWNxUyLp33WTrxNYY=; t=1751280347; x=1751885147; 
	b=c7zuP1pYpl/7jClrcP5vmlVuvuwAvu3bMz6IDSGKlYuz3IKZnnR+MFxJy0kR++jxaHNhf9PVGER
	izaLXvEVjPjTgb9k32l9fqx111sjz0mBEM7lqohKVShLm5+4UAzcArVuF+7SvY5tJMusW5sxM3s62
	V/DYAs8qhBb5KUrbPNiL4MH54pr0DBGNsiTBCF2ChtSCmBjYVVpqoY14KbXdXZINix8g85aCsoqEf
	VzIr9IfsHPeCrc/yXFk/BRt7XSbwfTrjcS5Hmeo8ccwLuF2Qhaqm+TZ1k0bPRS+fE/XUr+vPJV8tm
	o3HqJGQf8lTqCh4rAEe1KKrGNFuRIAamHrNw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uWC1A-0000000499Z-2hFo; Mon, 30 Jun 2025 12:45:44 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uWC1A-00000001qO8-1tjy; Mon, 30 Jun 2025 12:45:44 +0200
Message-ID: <5375b5bb7221cf878d1f93e60e72807f66e26154.camel@physik.fu-berlin.de>
Subject: Re: kernel/fork.c:3088:2: warning: clone3() entry point is missing,
 please fix
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, Dinh Nguyen
	 <dinguyen@kernel.org>, Simon Schuster
	 <schuster.simon+binutils@siemens-energy.com>, Linux-Arch
	 <linux-arch@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
Date: Mon, 30 Jun 2025 12:45:43 +0200
In-Reply-To: <46c6b0f6-6155-4366-9cbf-9fbbfb95ce30@app.fastmail.com>
References: <202506282120.6vRwodm3-lkp@intel.com>
	 <2ef5bc91-f56d-4c76-b12e-2797999cba72@app.fastmail.com>
	 <57101e901013a8e6ff44e10c93d1689490c714bf.camel@physik.fu-berlin.de>
	 <46c6b0f6-6155-4366-9cbf-9fbbfb95ce30@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Arnd,

On Mon, 2025-06-30 at 12:02 +0200, Arnd Bergmann wrote:
> Some architectures have custom calling conventions for the
> fork/vfork/clone/clone3 syscalls, e.g. to handle copying all the
> registers correctly when the normal syscall entry doesn't do that,
> or to handle the changing stack correctly.
>=20
> I see that both sparc and hexagon have a custom clone() syscall,
> so they likely need a custom clone3() as well, while sh and
> nios2 probably don't.
>=20
> All four would need a custom assembler implementation in userspace
> for each libc, in order to test the userspace calling the clone3()
> function. For testing the kernel entry point itself, see Christian's
> original test case[1].

Thanks for the explanation. So, I guess as long as a proposed implementatio=
n
of clone3() on sh would pass Arnd's test program, it should be good for mer=
ging?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

