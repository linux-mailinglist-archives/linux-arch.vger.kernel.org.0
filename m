Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8990933E087
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 22:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCPVbO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 17:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCPVbK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Mar 2021 17:31:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754E5C06174A
        for <linux-arch@vger.kernel.org>; Tue, 16 Mar 2021 14:31:10 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMHHM-00H5x6-6x; Tue, 16 Mar 2021 22:31:04 +0100
Message-ID: <87933c0d6c07745b20f6724721e3bf2da8f67f72.camel@sipsolutions.net>
Subject: Re: [RFC v8 08/20] um: lkl: memory handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        retrage01@gmail.com
Date:   Tue, 16 Mar 2021 22:31:03 +0100
In-Reply-To: <m28s6nc2w1.wl-thehajime@gmail.com> (sfid-20210316_021825_898828_61B64BB2)
References: <cover.1611103406.git.thehajime@gmail.com>
         <19d4990f2ef77ad595248183071da5e43149931c.1611103406.git.thehajime@gmail.com>
         <03c74a353c87994b61450ba8086f1ccda40b2ea8.camel@sipsolutions.net>
         <m28s6nc2w1.wl-thehajime@gmail.com> (sfid-20210316_021825_898828_61B64BB2)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-03-16 at 10:18 +0900, Hajime Tazaki wrote:
> 
> > > +void *uml_kmalloc(int size, int flags)
> > > +{
> > > +	return kmalloc(size, flags);
> > > +}
> > 
> > That could probably still be shared?
> 
> This function is a stub of arch/um/kernel/mem.c, which LKL doesn't
> use for the build.  Thus we defined here.
> 
> Or are you suggesting to not stubbing this function, but extracting
> the function from mem.c ?

Yes, that's kind of what I was thinking.

OTOH, I guess it's in os-Linux today?

johannes

