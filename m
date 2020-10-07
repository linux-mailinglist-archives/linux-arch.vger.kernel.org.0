Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61120286209
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 17:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgJGPZM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 11:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJGPZM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 11:25:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3ACC061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 08:25:12 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQBJT-000zSD-LO; Wed, 07 Oct 2020 17:25:07 +0200
Message-ID: <5502f24bcdc07372fbc5ee86c700770038b041c4.camel@sipsolutions.net>
Subject: Re: [RFC v7 07/21] um: extend arch_switch_to for alternate SUBARCH
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Wed, 07 Oct 2020 17:25:06 +0200
In-Reply-To: <d4a65be8d05d945885f53bc168fd85f08e72adf1.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <d4a65be8d05d945885f53bc168fd85f08e72adf1.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> This commit introduces additional argument of previous task when
> context switch happens.  New SUBARCH can use the new information to
> switch tasks in a subarch-specific manner.
> 
> The patch is particularly required by nommu mode implemented as a
> SUBARCH of UML.

Would probably be good to already say why here?

johannes

