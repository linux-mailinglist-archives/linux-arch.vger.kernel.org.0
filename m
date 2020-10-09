Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE2C288D99
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389252AbgJIQCT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389135AbgJIQCT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:02:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946D3C0613D2
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:02:19 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQuqT-002Mlq-Mk; Fri, 09 Oct 2020 18:02:13 +0200
Message-ID: <fe1413de641b25537ee2d4b7463c8fa5eb4b9993.camel@sipsolutions.net>
Subject: Re: [RFC v7 07/21] um: extend arch_switch_to for alternate SUBARCH
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        retrage01@gmail.com
Date:   Fri, 09 Oct 2020 18:02:12 +0200
In-Reply-To: <m2sgao42fa.wl-thehajime@gmail.com> (sfid-20201009_032432_010821_E55BA25D)
References: <cover.1601960644.git.thehajime@gmail.com>
         <d4a65be8d05d945885f53bc168fd85f08e72adf1.1601960644.git.thehajime@gmail.com>
         <5502f24bcdc07372fbc5ee86c700770038b041c4.camel@sipsolutions.net>
         <m2sgao42fa.wl-thehajime@gmail.com> (sfid-20201009_032432_010821_E55BA25D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2020-10-09 at 10:24 +0900, Hajime Tazaki wrote:
> On Thu, 08 Oct 2020 00:25:06 +0900,
> Johannes Berg wrote:
> > On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> > > This commit introduces additional argument of previous task when
> > > context switch happens.  New SUBARCH can use the new information to
> > > switch tasks in a subarch-specific manner.
> > > 
> > > The patch is particularly required by nommu mode implemented as a
> > > SUBARCH of UML.
> > 
> > Would probably be good to already say why here?
> 
> Agree.
> 
> The patch is particularly required by nommu mode because it uses
> previous task information to control the previous thread (e.g., down
> semaphore, terminate thread, clean up thread flags).
> 
> Something like this ?

Well, still not sure I like "nommu" to refer to "library mode", but I'm
also not sure that you can understand that without the context of how
threads actually work in library mode?

Maybe even something vague like

   Having access to the previous thread will be required in library mode
   for it to implement thread switching correctly.

would give some rationale?

johannes

