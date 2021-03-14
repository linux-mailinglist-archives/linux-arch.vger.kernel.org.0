Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D5C33A701
	for <lists+linux-arch@lfdr.de>; Sun, 14 Mar 2021 17:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhCNQus (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Mar 2021 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhCNQuf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Mar 2021 12:50:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDBBC061574
        for <linux-arch@vger.kernel.org>; Sun, 14 Mar 2021 09:50:33 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lLTwi-00G3Fk-8S; Sun, 14 Mar 2021 17:50:28 +0100
Message-ID: <e18da756e9efcae8489c658907b62d68f0969da0.camel@sipsolutions.net>
Subject: Re: [RFC v8 07/20] um: lkl: host interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Sun, 14 Mar 2021 17:50:27 +0100
In-Reply-To: <f149135f1943eb81998d54c923c10ebffb0b4518.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
         <f149135f1943eb81998d54c923c10ebffb0b4518.1611103406.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> +/**
> + * struct lkl_host_operations - host operations used by the Linux kernel
> + *
> + * These operations must be provided by a host library or by the application
> + * itself.
> + *
> + */
> +struct lkl_host_operations {
> +};

IIRC, in previous reviews we discussed this and you said you'd look at
just making those extern functions, instead of function pointers, since
realistically there's no use in being able to switch these at runtime.
What happened to that? Any particular reason not to?

johannes

