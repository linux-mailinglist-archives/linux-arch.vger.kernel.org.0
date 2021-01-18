Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9A32F99C5
	for <lists+linux-arch@lfdr.de>; Mon, 18 Jan 2021 07:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbhARGQD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Jan 2021 01:16:03 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:51756 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbhARGQA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Jan 2021 01:16:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610950542; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=A8wI3RTGCyles0FltZDIkYEHIfDYCgkxz4YJBJIsSfk=;
 b=YFKj5gW3cJpnj70JK2rqamejicWbqOwz57uhA6DNbcx0WAucdaot0krPASVKnQP6ED1MIFLY
 +gNmdCznozcivJPvGMOjOVEmhCY5pDZjRrw7301vKlIZWBO+g3EYN4YG8EBmXDKT1oAgHqx/
 UgWBdwHrnZXAn8GWTPYYsFxIdpE=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6005276e7086580d32248cee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 06:15:10
 GMT
Sender: pnagar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 035E9C433C6; Mon, 18 Jan 2021 06:15:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pnagar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6FFC4C433CA;
        Mon, 18 Jan 2021 06:15:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Jan 2021 11:45:08 +0530
From:   pnagar@codeaurora.org
To:     David Howells <dhowells@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, arnd@arndb.de,
        jmorris@namei.org, serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-arch@vger.kernel.org, psodagud@codeaurora.org,
        nmardana@codeaurora.org, dsule@codeaurora.org,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] selinux: security: Move selinux_state to a
 separate page
In-Reply-To: <2646561.1610535404@warthog.procyon.org.uk>
References: <e6bd9820-8b77-57fc-f318-9b928e4d951b@schaufler-ca.com>
 <1610099389-28329-1-git-send-email-pnagar@codeaurora.org>
 <0f467390-e018-6051-0014-ab475ed76863@schaufler-ca.com>
 <dab6357acbd63edd53099d106d111bf4@codeaurora.org>
 <2646561.1610535404@warthog.procyon.org.uk>
Message-ID: <87b4c1b961fcd94c6e34ab314e2c1dff@codeaurora.org>
X-Sender: pnagar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-01-13 16:26, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
>> >> How would this interact with or complement __read_mostly?
>> >>
>> > Currently, the mechanism we are working on developing is
>> > independent of __read_mostly. This is something we can look more into
>> > while working further on the mechanism.
>> 
>> Please either integrate the two or explain how they differ.
>> It appears that you haven't considered how you might exploit
>> or expand the existing mechanism.
> 
> I think __read_mostly is about grouping stuff together that's rarely 
> going to
> be read to make the CPU's data cache more efficient.  It doesn't stop 
> people
> writing to such a variable.
> 
> David
Thank you for sharing!
