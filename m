Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E5AC98B6
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 08:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfJCG4X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Oct 2019 02:56:23 -0400
Received: from albireo.enyo.de ([37.24.231.21]:55484 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfJCG4W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Oct 2019 02:56:22 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iFv2B-0004Rw-8R; Thu, 03 Oct 2019 06:56:19 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iFv2B-0003Et-45; Thu, 03 Oct 2019 08:56:19 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Jann Horn <jannh@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
        <201910011140.EA0181F13@keescook>
Date:   Thu, 03 Oct 2019 08:56:19 +0200
In-Reply-To: <201910011140.EA0181F13@keescook> (Kees Cook's message of "Tue, 1
        Oct 2019 11:46:45 -0700")
Message-ID: <87y2y271ws.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Is anyone else getting a very incomplete set of messages in this
thread?

These changes likely matter to glibc, and I've yet to see the actual
patch.  Would someone please forward it to me?

The original message didn't make it into the lore.kernel.org archives
(the cross-post to linux-kernel should have taken care of that).
