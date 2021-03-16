Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050DE33E095
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 22:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhCPVdY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 17:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCPVcz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Mar 2021 17:32:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D6C06174A
        for <linux-arch@vger.kernel.org>; Tue, 16 Mar 2021 14:32:52 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMHJ0-00H5yx-5D; Tue, 16 Mar 2021 22:32:46 +0100
Message-ID: <56af0e44c846f4b079256ec997c56119964be402.camel@sipsolutions.net>
Subject: Re: [RFC v8 19/20] um: lkl: add block device support of UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        retrage01@gmail.com
Date:   Tue, 16 Mar 2021 22:32:45 +0100
In-Reply-To: <m25z1rc2ux.wl-thehajime@gmail.com> (sfid-20210316_021905_632656_6C735A12)
References: <cover.1611103406.git.thehajime@gmail.com>
         <b3b73864dbb738d0de7c49a6df5a5f53a358ec93.1611103406.git.thehajime@gmail.com>
         <2b649bc5165c7ff4547abd72f7e03e7491980138.camel@sipsolutions.net>
         <m25z1rc2ux.wl-thehajime@gmail.com> (sfid-20210316_021905_632656_6C735A12)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-03-16 at 10:19 +0900, Hajime Tazaki wrote:
> 
> > > --- a/arch/um/Kconfig
> > > +++ b/arch/um/Kconfig
> > > @@ -29,6 +29,10 @@ config UMMODE_LIB
> > >  	select UACCESS_MEMCPY
> > >  	select ARCH_THREAD_STACK_ALLOCATOR
> > >  	select ARCH_HAS_SYSCALL_WRAPPER
> > > +	select VFAT_FS
> > > +	select NLS_CODEPAGE_437
> > > +	select NLS_ISO8859_1
> > > +	select BTRFS_FS
> > 
> > That doesn't really seem to make sense - the sample might need it, but
> > generally LKL doesn't/shouldn't?
> 
> I'm trying to understand your comment;
> Do you mean that enabling those options in Kconfig doesn't make sense ?

I mean *always* enabling them doesn't make sense. Why shouldn't somebody
be allowed to build UMMODE_LIB *without* btrfs? If they have no need for
btrfs, why should it select it?

I can understand that your sample code wants btrfs just to show what it
can do, but IMHO it doesn't make sense to *always* enable it.

> and if you mean the sample as sample code, is the added test case
> (e.g., tools/testing/selftests/um/disk.c, which is included in the
> same patch) for this purpose ?

yes, that's what I mean by "sample code"

joahnnes

