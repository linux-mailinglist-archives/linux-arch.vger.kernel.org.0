Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D54D34008F
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 09:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCRIBZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 04:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhCRIBJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Mar 2021 04:01:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E0C06174A
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2021 01:01:09 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMnaP-000522-3b; Thu, 18 Mar 2021 09:00:53 +0100
Message-ID: <0264c509792ed110ca47a7eeef16cbfa119dd320.camel@sipsolutions.net>
Subject: Re: [RFC v8 08/20] um: lkl: memory handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        retrage01@gmail.com
Date:   Thu, 18 Mar 2021 09:00:52 +0100
In-Reply-To: <m2zgz19v6y.wl-thehajime@gmail.com> (sfid-20210318_011203_531127_A4687028)
References: <cover.1611103406.git.thehajime@gmail.com>
         <19d4990f2ef77ad595248183071da5e43149931c.1611103406.git.thehajime@gmail.com>
         <03c74a353c87994b61450ba8086f1ccda40b2ea8.camel@sipsolutions.net>
         <m28s6nc2w1.wl-thehajime@gmail.com>
         <87933c0d6c07745b20f6724721e3bf2da8f67f72.camel@sipsolutions.net>
         <m2zgz19v6y.wl-thehajime@gmail.com> (sfid-20210318_011203_531127_A4687028)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2021-03-18 at 09:12 +0900, Hajime Tazaki wrote:
> 
> sorry, I didn't get this line.  uml_kmalloc() is in kernel/mem.c but
> what is in os-Linux ?

Never mind, I was just confused.

johannes

