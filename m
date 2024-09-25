Return-Path: <linux-arch+bounces-7428-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35237986456
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 17:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3121C23F0A
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631411BC2A;
	Wed, 25 Sep 2024 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UVKMXiTj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VkQkxhzM"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8AA18637;
	Wed, 25 Sep 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279955; cv=none; b=sa3WV09dVjCJIafIgmJk2N19Jdlj4pASEe6ccIBr1YJXkX3hNuCqg7AjFjdfe2bdAKGjK+yIDFR38IXi9HzjCfvohiUX7s10aexaOah4ORmy7e9hMhJgfDeIrmBrhkTjXcsnj6qll1LUBcsqPZuuDVTiKuRpPbGAJgK/2MJsMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279955; c=relaxed/simple;
	bh=yaiCoyV8POwmw8mOFb1CvfBnHJKh54ULmKz45sixybQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sR6mKxNyUsHZ9p8KwYp6mnBXK+81DWVn8SWXpavv2Kfhigs1vRNqgAt7l6GYZup1UB0DQC04k5mMJeeeQLoAw1XRJk2rOwz7nt/xwgXFm9ux6fDmqlGt6CeV1rURVK2DCI1b0ys5pWTf9Xwi6sAluwk/cqqE/TOHSxCJa5BneWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UVKMXiTj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VkQkxhzM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id ECD7113803AA;
	Wed, 25 Sep 2024 11:59:10 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 25 Sep 2024 11:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727279950;
	 x=1727366350; bh=3HZx7sec5GV7f3nA3v8u1Fjv7A5gsnEaqY5PBAiqOkk=; b=
	UVKMXiTjaRWc30bxZNATVWbRhgICrxpyR1x16ghxJOAQTl5BOunfXp9FwWV9WhlV
	+aUa/RGQh0Kyz4py6ifpIJ0+eLmjwMyTDfXsi0XWrcC8RcdTOOgH0YZTuBZbucr/
	z2c10MA43k2yciVzwTab6t6eXgWSHOOzeHnWuiGcynxher7cWBmML1U9Sevdd5iI
	uzvkVwSmr0CDT4xYR/kN0N6RZhrsVcoWwgNNDis6Dv19wAKQhSHm5ns+KjaDg8od
	S9wcHRzFhbGHOVeS9mXFTuId4wpU9p1MK04NIfi1O27zhlWafosj7W3qPNzL6+H+
	DB2IwVwmKjOI85hzhAEKpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727279950; x=
	1727366350; bh=3HZx7sec5GV7f3nA3v8u1Fjv7A5gsnEaqY5PBAiqOkk=; b=V
	kQkxhzMWnh9soxOXto4eo35XEnniTH4Wu+9ZskAHzs93bDP7LBa6DgPrj6HceGdo
	8YKYsjg/9l4PP68f+e9rStsWE3nv4yrfFwW9zxVUxAAoxu92B7DwkCnMDEB5z++5
	B2Uj+lbSbXt+XIWbOH6RMp3gHONT6vsyJTj7kIzfZlBMjfQMJfIdjyljGakAIjbV
	dxtEToc/zuQB6+/68rKtO42kB6GLy1P4svOtLC8opNfW/Ibh4Rj6RfYs1tmv6qEF
	/xMtI7xZqb2slX9RiE52KgOWpCCVFgL5Cu2jlVC9WPk3512KFFuAVu9ynYuhKCE0
	r2M9NYYjcQEpvrsJmEDGg==
X-ME-Sender: <xms:TTP0ZqmgT4Iz-DjvOhb6TEsmbNcedL4jv-HXEBZ14JusRndh8E3guQ>
    <xme:TTP0Zh1aAfi2-W_sHtCvZrcYc2NMKYejucSvVVwIJzXQiogHFgrFj3dCt8w6MAvoP
    d41cQblQb2fa8wiyNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddthedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeek
    keelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeegtddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhm
    pdhrtghpthhtohepuhgsihiijhgrkhesghhmrghilhdrtghomhdprhgtphhtthhopegrrh
    gusgdoghhithesghhoohhglhgvrdgtohhmpdhrtghpthhtohepihhrohhgvghrshesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepjhhushhtihhnshhtihhtthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghp
    thhtoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphhtthhope
    hkvghithhhpheskhgvihhthhhprdgtohhmpdhrtghpthhtoheprggtmhgvsehkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:TTP0ZorEpf8uhg8h7KUOuuyxmkFTuOqd8M-ijgxDXgHXHnEsCAqn1A>
    <xmx:TTP0ZukWROg85Ojj1n7scTnPh_o5BOn4tFS4d6Wlg35ADB7gm5yxxQ>
    <xmx:TTP0Zo3bonoZfA7r9k_xttbCf96LxvWQCw6nio7M3wIvLzzRaNhFBA>
    <xmx:TTP0ZlvFerWdcwY5EIw3orvEavM3V7Yt9LqH5F0Xmjy4Y5rHiisqdQ>
    <xmx:TjP0ZmWuFxpdl1lIuEttTBR3BrOqJ-pJA32wqZmkpWVgyRHgKyKtEXao>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 792C62220071; Wed, 25 Sep 2024 11:59:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Sep 2024 15:58:38 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ard Biesheuvel" <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: "Ard Biesheuvel" <ardb@kernel.org>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Uros Bizjak" <ubizjak@gmail.com>, "Dennis Zhou" <dennis@kernel.org>,
 "Tejun Heo" <tj@kernel.org>, "Christoph Lameter" <cl@linux.com>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Vitaly Kuznetsov" <vkuznets@redhat.com>,
 "Juergen Gross" <jgross@suse.com>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Keith Packard" <keithp@keithp.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>,
 "Ian Rogers" <irogers@google.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "Kan Liang" <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-efi@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-sparse@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <c4868f63-b688-4489-a112-05bf04280bde@app.fastmail.com>
In-Reply-To: <20240925150059.3955569-32-ardb+git@google.com>
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-32-ardb+git@google.com>
Subject: Re: [RFC PATCH 02/28] Documentation: Bump minimum GCC version to 8.1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 25, 2024, at 15:01, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Bump the minimum GCC version to 8.1 to gain unconditional support for
> referring to the per-task stack cookie using a symbol rather than
> relying on the fixed offset of 40 bytes from %GS, which requires
> elaborate hacks to support.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  Documentation/admin-guide/README.rst | 2 +-
>  Documentation/process/changes.rst    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>

As we discussed during plumbers, I think this is reasonable,
both the gcc-8.1 version and the timing after the 6.12-LTS
kernel.

We obviously need to go through all the other version checks
to see what else can be cleaned up. I would suggest we also
raise the binutils version to 2.30+, which is what RHEL8
shipped alongside gcc-8. I have not found other distros that
use older binutils in combination with gcc-8 or higher,
Debian 10 uses binutils-2.31.
I don't think we want to combine the additional cleanup with
your series, but if we can agree on the version, we can do that
in parallel.

FWIW, here are links to the last few times we discussed this,
and there are already has a few other things that would
benefit from more modern compilers:

https://lore.kernel.org/lkml/dca5b082-90d1-40ab-954f-8b3b6f51138c@app.fastmail.com/
https://lore.kernel.org/lkml/CAFULd4biN8FPRtU54Q0QywfBFvvWV-s1M3kWF9YOmozyAX9+ZQ@mail.gmail.com/
https://lore.kernel.org/lkml/CAK8P3a1Vt17Yry_gTQ0dwr7_tEoFhuec+mQzzKzFvZGD5Hrnow@mail.gmail.com/

     Arnd

