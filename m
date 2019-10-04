Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27792CB501
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2019 09:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfJDHbl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Oct 2019 03:31:41 -0400
Received: from albireo.enyo.de ([37.24.231.21]:55344 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfJDHbl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Oct 2019 03:31:41 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iGI3q-0003Ze-K5; Fri, 04 Oct 2019 07:31:34 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iGI3j-0004HM-7q; Fri, 04 Oct 2019 09:31:27 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Jann Horn <jannh@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
        postmaster@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: vger mail woes? (was: Re: [RFC][PATCH] sysctl: Remove the sysctl system call)
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
        <201910011140.EA0181F13@keescook> <87y2y271ws.fsf@mid.deneb.enyo.de>
        <20191003210814.gh7rbbv6bpxlhz3w@wittgenstein>
Date:   Fri, 04 Oct 2019 09:31:27 +0200
In-Reply-To: <20191003210814.gh7rbbv6bpxlhz3w@wittgenstein> (Christian
        Brauner's message of "Thu, 3 Oct 2019 23:08:14 +0200")
Message-ID: <87bluxge5s.fsf_-_@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Christian Brauner:

> On Thu, Oct 03, 2019 at 08:56:19AM +0200, Florian Weimer wrote:
>> Is anyone else getting a very incomplete set of messages in this
>> thread?
>> 
>> These changes likely matter to glibc, and I've yet to see the actual
>> patch.  Would someone please forward it to me?
>> 
>> The original message didn't make it into the lore.kernel.org archives
>> (the cross-post to linux-kernel should have taken care of that).
>
> Yeah, I didn't get it either and the repost too weirdly enough.

I got curious and tried to repost the repost to vger.kernel.org (in
the hope to bypass any SMTP callout verifications that may still be
failing for Eric), and got this:

2019-10-04 07:09:29 1iGHiT-00007b-Na <= fw@deneb.enyo.de H=(deneb.enyo.de) [172.17.203.2] P=esmtps X=TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256 CV=no S=72580 id=87h84pgf6h.fsf@mid.deneb.enyo.de
2019-10-04 07:09:37 1iGHiT-00007b-Na => linux-api@vger.kernel.org R=dnslookup T=remote_smtp_ext H=vger.kernel.org [209.132.180.67] C="250 2.7.1 Looks like Linux source DIFF email.. BF:<S 1>; S1728766AbfJDHJg"
2019-10-04 07:09:37 1iGHiT-00007b-Na -> linux-arch@vger.kernel.org R=dnslookup T=remote_smtp_ext H=vger.kernel.org [209.132.180.67] C="250 2.7.1 Looks like Linux source DIFF email.. BF:<S 1>; S1728766AbfJDHJg"
2019-10-04 07:09:37 1iGHiT-00007b-Na -> linux-kernel@vger.kernel.org R=dnslookup T=remote_smtp_ext H=vger.kernel.org [209.132.180.67] C="250 2.7.1 Looks like Linux source DIFF email.. BF:<S 1>; S1728766AbfJDHJg"
2019-10-04 07:09:37 1iGHiT-00007b-Na Completed

But nothing came back.  Timestamps are UTC.

Dave, could please have a look, assuming that you are still involved
with vger operations?
