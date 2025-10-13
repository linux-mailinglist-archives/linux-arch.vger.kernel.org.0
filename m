Return-Path: <linux-arch+bounces-14041-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6503BD26A1
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 12:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE6854F0039
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEDA2FE575;
	Mon, 13 Oct 2025 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYGb4s7P"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2A2FE568
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349601; cv=none; b=HZFKCjCRB0S80cDHMTEOgRObVNs1IXVsxDg+mPf1NNg3AIVFT1YLEx5PZBZoyvb9iAb0q+ACzx1OgVVUQLOsYbhwfsCVRpg+a/XH/tCLjmuTCfsVe1ax9TuAd3DJsjFErEf1B112eQtKBYX6FjCejuHAw913EvgekspA0jD+W4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349601; c=relaxed/simple;
	bh=+zOuCBbttI2pym4Pdpz046IX8ZPwrX2sj4yc80Raf0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnNWvvWOjsBO7WcdZZkbhIiPrRyC/2CIDMCMnA7sUIvCqiioxTeM+uY3ZHD+PEWkr8Y4XAUt89VS7OWFvotz/tr2WBEFB1qxVJolxvx3Wtqgz0aGnU3rTN1yvgIiMMGvQf5krllxVHgSE/roJ+RgrJGdqiPJVZalBBOmqio4pwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYGb4s7P; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6348447d5easo3766430d50.0
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 02:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760349599; x=1760954399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZsaCMPk0e7xOahYxc9B2HTwzlp/3SZdj7OzfRUl7Tc=;
        b=lYGb4s7PFPtlQAqGLwjY6C3BoptYCrvsiQTPmRJWe0jrmue4kzt875LXGc+nwMus5e
         gg/dRRivympKqj/Xbh/kqv4jfo3sNkaRAWWH4kZP7QO+EYk91Xl5ZvumS/kg92GHtPjk
         j1DbxG/Dgk3vmqFQjqZbS6cxMNqHU4DeIsE2rSdChE2dhflRSZVNKpBaEr6XVXJ3d+35
         Uw6w91MZJuEBrgw2xCsk0gcBTZMcncRHXUPfRkRDe21ahILoyvU3E/QbhqdS6KHwrvfA
         79Um23YLTNO6t/m7Vr/uQlJA0nZ6SxJWNCgTAeqdZEx/sH8Vu9rR490wZ3vArZnHDyqH
         MjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349599; x=1760954399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZsaCMPk0e7xOahYxc9B2HTwzlp/3SZdj7OzfRUl7Tc=;
        b=odvwtBgGeOcuwVs2/OVUse+YTGFzHCu5xdifzkOcrPsybSFFPke+mDWKXDguApfY6D
         agvQOWw/3FnOMLM1UlMGgtlOzNph/Fvdks/6Ph1/K2j7jJpO08LHBNKwxnInoUNH0Ird
         ydYBxN5MS0h7QtSkHItpei/F5M/xWGlizJOTMkJge+WGsyXroyHary/0w2/M73ci9ImO
         x2o25uTrg17b4jd6gdLmARSaeSyKi5SJNucHM4lbKik+dOoQKUXOdHUbBjwJAqTNRorv
         dBwCyoUtQIpYNAxIg/N2PCEBhEDzwjEOcnl9G9Pv/yk3a4NlppCXkkOVJ/HSYit+pLKb
         M6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWvaOfxN4IVQTXiyNysbcHZaBzxdEZSIBOxTZdW1H/44Q7PY2fm92ZB3Y1EzUP7zII+1wGR8Ejv1U9q@vger.kernel.org
X-Gm-Message-State: AOJu0YxS1dogkff/71V/RnbQxXzO29MKxdQfE4J6df1v0WUnEYSSQae8
	eWI/EOO3jcYtCDLmU2FaqfgtOcPffkzzohsZeO0KwYBJBGuKotdRSGE570n0nbCjRAD7f7/2NYt
	h7q2uHGpogh5iIy1S23FGu7vYddwjbNA=
X-Gm-Gg: ASbGncv08r4h0opNeETQQF/cNoc4yPRNdfl+xs0j0MZ6OGsiwpBpdsC/77pcQMxy6Vd
	vagzdiaYdhsmpqoM6pSOSv/PKvwnXrP2VuAx0a/EWwQpjazzy0QDfEzt4sS6FdbFY6L3lw4s2li
	wPh0VSQ7liQQjcqT8qJMtsDHzDFmahKqkC/T8RZ2PC4yoR43gSMcB7+l2GAqrUlGg31mr2alu6Y
	L+ER52ALQ89EJpteBc28xXXETZCIBynv2eJ
X-Google-Smtp-Source: AGHT+IEjiQMnhpQ/Kb5hfGFGrybCEQQLnH8Bm2H6/rcdu7ghvXP+Te8kpl6LHQn/PIgvNHwUMvVrGJdsfOorS0mdutU=
X-Received: by 2002:a53:ee07:0:b0:63c:daf9:bf21 with SMTP id
 956f58d0204a3-63cdaf9fa65mr11783686d50.24.1760349598638; Mon, 13 Oct 2025
 02:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com>
 <20251010094047.3111495-3-safinaskar@gmail.com> <CAHp75VezkZ7A1VOP8cBH8h0DKVumP66jjUbepMCP87wGOrh+MQ@mail.gmail.com>
In-Reply-To: <CAHp75VezkZ7A1VOP8cBH8h0DKVumP66jjUbepMCP87wGOrh+MQ@mail.gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 13 Oct 2025 12:59:21 +0300
X-Gm-Features: AS18NWA-897xF_-UIFWa7pg6NN4-821ID7y01MXNqW6009NHHhcR0gsdnks-4OY
Message-ID: <CAPnZJGBAc-kqZ-MAKRGrk1big=N_GZupxKgM_+TodqgteffLvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] initrd: remove deprecated code path (linuxrc)
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Aleksa Sarai <cyphar@cyphar.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Nicolas Schichan <nschichan@freebox.fr>, David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 6:05=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> > -       noinitrd        [RAM] Tells the kernel not to load any configur=
ed
> > +       noinitrd        [Deprecated,RAM] Tells the kernel not to load a=
ny configured
> >                         initial RAM disk.
>
> How one is supposed to run this when just having a kernel is enough?
> At least (ex)colleague of mine was a heavy user of this option for
> testing kernel builds on the real HW.

This option applies to initrd only, not to initramfs.
Except for EFI mode, when it applies to both.

I will remove this option when I remove initrd.

In EFI mode it is easy just not to pass initramfs, so all is okay.

Also I will clarify docs in v3.

Also, please, answer here:
https://lore.kernel.org/regressions/20250918183336.5633-1-safinaskar@gmail.=
com/

--=20
Askar Safin

