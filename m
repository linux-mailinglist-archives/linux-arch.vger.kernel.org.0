Return-Path: <linux-arch+bounces-689-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFD98044DB
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFDC28113E
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13198BEA;
	Tue,  5 Dec 2023 02:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kiauXGfO"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257A62718;
	Mon,  4 Dec 2023 18:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+Sh4xFuCYtuZDODA0SGnrOJqkTBCw1GOJElB1RwG75Y=; b=kiauXGfOGc/a/PeytVXFZv7qSq
	niZtmA7lcKvUb5/b2C/4YdYhZ0yk+mypc+QzHzy7qgHV3cnWadFuYC15RY7+v65726NgOqj6o6+tq
	pGzgSzdb1RxwH5BBf3KX28A0YnHSSfxdQTv05SIV4UQc2z00epfxvpq0NCxQsiha1Vr0h5DVNj58c
	/jsrnzobFi+XIysxaJjQfX8eaV+nh81MViccJVmngzjORQUHauwQEjM2VglQs3aJSgkc4f8xDZvYC
	WCdJ1gkWQSby5c/unzmDksm6mTzufIlpSM2bPZ38hHaRdw2iBYUoyBTxDamMNGYfsYV4oaPxt4ndd
	YIMUSFIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL9q-0079CL-1x;
	Tue, 05 Dec 2023 02:27:34 +0000
Date: Tue, 5 Dec 2023 02:27:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: gus Gusenleitner Klaus <gus@keba.com>, Al Viro <viro@ftp.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC][PATCHES v2] checksum stuff
Message-ID: <20231205022734.GC1674809@ZenIV>
References: <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV>
 <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV>
 <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV>
 <20231022194020.GA972254@ZenIV>
 <20231205022100.GB1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205022100.GB1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 05, 2023 at 02:21:00AM +0000, Al Viro wrote:

Arrrgghhh...

Sorry about the crap mixed into that - git send-email .... v2-* without
checking if there are old files matching the same pattern remain.

Shouldn't have skipped --dry-run; mea culpa.

