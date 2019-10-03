Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88E3CCB0CE
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 23:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfJCVIS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Oct 2019 17:08:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58302 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfJCVIS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Oct 2019 17:08:18 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iG8Kd-0002Eh-Gw; Thu, 03 Oct 2019 21:08:15 +0000
Date:   Thu, 3 Oct 2019 23:08:14 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Jann Horn <jannh@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
Message-ID: <20191003210814.gh7rbbv6bpxlhz3w@wittgenstein>
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
 <201910011140.EA0181F13@keescook>
 <87y2y271ws.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y2y271ws.fsf@mid.deneb.enyo.de>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 03, 2019 at 08:56:19AM +0200, Florian Weimer wrote:
> Is anyone else getting a very incomplete set of messages in this
> thread?
> 
> These changes likely matter to glibc, and I've yet to see the actual
> patch.  Would someone please forward it to me?
> 
> The original message didn't make it into the lore.kernel.org archives
> (the cross-post to linux-kernel should have taken care of that).

Yeah, I didn't get it either and the repost too weirdly enough.

Christian
