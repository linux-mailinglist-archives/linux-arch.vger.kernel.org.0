Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CED288D91
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbgJIQAg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388882AbgJIQAg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:00:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421F0C0613D2
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:00:36 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQuom-002MiE-NH; Fri, 09 Oct 2020 18:00:28 +0200
Message-ID: <bb9e774e3115078623cdbec12d1b05bc2fdd87d7.camel@sipsolutions.net>
Subject: Re: [RFC v7 06/21] scritps: um: suppress warnings if SRCARCH=um
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        retrage01@gmail.com
Date:   Fri, 09 Oct 2020 18:00:27 +0200
In-Reply-To: <m2tuv442wu.wl-thehajime@gmail.com> (sfid-20201009_031344_500332_274F29B0)
References: <cover.1601960644.git.thehajime@gmail.com>
         <e994b27b4732a21a571cf09bd5071f583d85dd89.1601960644.git.thehajime@gmail.com>
         <5caf34d16a0f2816b47cd8712ca7d59e9733a815.camel@sipsolutions.net>
         <m2tuv442wu.wl-thehajime@gmail.com> (sfid-20201009_031344_500332_274F29B0)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2020-10-09 at 10:13 +0900, Hajime Tazaki wrote:
> 
> > and maybe only when actually building for NOMMU/LKL?
> 
> The standalone UML doesn't use the headers_install.sh script (AFAIK),
> so I think this would be okay.

Yes, I was more thinking in terms of documenting the purpose in the
code, similar really to the argument I made elsewhere about "NOMMU" vs
"LKL mode".

johannes

