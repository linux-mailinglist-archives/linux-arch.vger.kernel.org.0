Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32EB28E25A
	for <lists+linux-arch@lfdr.de>; Wed, 14 Oct 2020 16:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbgJNOj1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 10:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgJNOj1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Oct 2020 10:39:27 -0400
Received: from coco.lan (ip5f5ad5dc.dynamic.kabel-deutschland.de [95.90.213.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 708DC212CC;
        Wed, 14 Oct 2020 14:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602686366;
        bh=X8ubeEjZ99j+8NJhXZjoq8ZW3JexJrjS0NMZOekuGws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DO+ZnhE0EH9wSQFptWtkdzX8isDiIl02JoBSOtVXa6vghPsjxC8tenehEDhFzvute
         WhOByyD4o9W1Uh198gOJdYDDTXO4J+PQxd2/YycG4wQiPTxv+EL52VaaZYvu32/6tz
         DpXXlqSghyX5RQOGpAXdot945EkDB6AJ4QcspG6I=
Date:   Wed, 14 Oct 2020 16:39:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/24] tools: docs: memory-model: fix references for
 some files
Message-ID: <20201014163919.4bb6f8c2@coco.lan>
In-Reply-To: <aaeeba66-48be-0354-8f1c-261b361ae17f@gmail.com>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
        <44baab3643aeefdb68f1682d89672fad44aa2c67.1602590106.git.mchehab+huawei@kernel.org>
        <20201013163354.GO3249@paulmck-ThinkPad-P72>
        <20201013163836.GC670875@rowland.harvard.edu>
        <20201014015840.GR3249@paulmck-ThinkPad-P72>
        <20201014095603.0d899da7@coco.lan>
        <aaeeba66-48be-0354-8f1c-261b361ae17f@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em Wed, 14 Oct 2020 23:14:00 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Wed, 14 Oct 2020 09:56:03 +0200, Mauro Carvalho Chehab wrote:
> > Em Tue, 13 Oct 2020 18:58:40 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> escreveu:
> >  =20
> >> On Tue, Oct 13, 2020 at 12:38:36PM -0400, Alan Stern wrote: =20
> >>> On Tue, Oct 13, 2020 at 09:33:54AM -0700, Paul E. McKenney wrote:   =
=20
> >>>> On Tue, Oct 13, 2020 at 02:14:29PM +0200, Mauro Carvalho Chehab wrot=
e:   =20
> >>>>> - The sysfs.txt file was converted to ReST and renamed;
> >>>>> - The control-dependencies.txt is not at
> >>>>>   Documentation/control-dependencies.txt. As it is at the
> >>>>>   same dir as the README file, which mentions it, just
> >>>>>   remove Documentation/.
> >>>>>
> >>>>> With that, ./scripts/documentation-file-ref-check script
> >>>>> is now happy again for files under tools/.
> >>>>>
> >>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>   =
=20
> >>>>
> >>>> Queued for review and testing, likely target v5.11.   =20
> >>>
> >>> Instead of changing the path in the README reference, shouldn't=20
> >>> tools/memory-model/control-dependencies.txt be moved to its proper=20
> >>> position in .../Documentation?   =20
> >>
> >> You are of course quite right.  My thought is to let Mauro go ahead,
> >> given his short deadline.  We can then make this "git mv" change once
> >> v5.10-rc1 comes out, given that it should have Mauro's patches.  I have
> >> added a reminder to my calendar. =20
> >=20
> > Sounds like a plan to me.
> >=20
> >=20
> > If it helps on 5.11 plans, converting this file to ReST format is quite
> > trivial: it just needs to use "::" for C/asm code literal blocks, and=20
> > to replace "(*) " by something that matches ReST syntax for lists,
> > like "(#) " or just "* ":
> >=20
> > 	https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#bul=
let-lists
> >=20
> > See enclosed. =20
>=20
> I'm afraid conversion of LKMM documents to ReST is unlikely to happen
> any time soon.
> It should wait until such time comes when the auto markup tools become
> clever enough and .rst files looks exactly the same as plain .txt files.
>=20
> Am I asking too much? :-)
>=20
>         Thanks, Akira

Yes :-)

	$ git log --author akiyks@gmail.com Documentation/sphinx
	$

The auto markup tools don't write themselves alone. Someone needs=20
to write them and test if no regressions will happen with the existing
documents.

-

That's said, I suspect that one of the hardest things for something
like that to be possible is to be able to distinguish something
like:

	(some text)

=46rom something like:

	/* some C code snippet or bash script, or other literal block */

So, at least "::" (or some other markup replacing it) is needed.

If you have some bright idea about how to implement it, feel free
to contribute with patches.

Thanks,
Mauro
