Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457F91E629B
	for <lists+linux-arch@lfdr.de>; Thu, 28 May 2020 15:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390546AbgE1NpM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 May 2020 09:45:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58601 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390432AbgE1NpH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 May 2020 09:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590673506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Re4jEEmAvLF/IwOE4h8IS6wOLBf53DSbCjXiPd7qbRw=;
        b=eFEFLx+1a4HWFjnLGWV6Jyjg0ZiNvRc/kW1kLadciIr44Rz7oki/l1dWKuu05XLjmd0uW6
        hNAQTOVsjvOzvxnxs7juxQeckP4uxzSPWk7ua6MBjoeOTB/WKic/iZMFjUGBndJ8zAV0PV
        U0KIuO0pbcKFFAKAXAXQ69z1I2TfyJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-i0VHkOeVO46Jri8xBsBn8A-1; Thu, 28 May 2020 09:45:02 -0400
X-MC-Unique: i0VHkOeVO46Jri8xBsBn8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39D4918FE860;
        Thu, 28 May 2020 13:45:01 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-217.rdu2.redhat.com [10.10.118.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 895637A1EF;
        Thu, 28 May 2020 13:45:00 +0000 (UTC)
Subject: Re: [PATCH v2 3/6] prctl.2: Add PR_SPEC_DISABLE_NOEXEC for
 SPECULATION_CTRL prctls
To:     Dave Martin <Dave.Martin@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-4-git-send-email-Dave.Martin@arm.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <35acb48d-6703-bed5-8c6d-739411eea679@redhat.com>
Date:   Thu, 28 May 2020 09:45:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1590614258-24728-4-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/27/20 5:17 PM, Dave Martin wrote:
> Add the PR_SPEC_DISABLE_NOEXEC mode added in Linux 5.1
> for the PR_SPEC_STORE_BYPASS "misfeature" of
> PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>   man2/prctl.2 | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index b6fb51c..cab9915 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1187,6 +1187,12 @@ The speculation feature is disabled, mitigation is enabled.
>   Same as
>   .B PR_SPEC_DISABLE
>   but cannot be undone.
> +.TP
> +.BR PR_SPEC_DISABLE_NOEXEC " (since Linux 5.1)"
> +Same as
> +.BR PR_SPEC_DISABLE ,
> +but but the state will be cleared on
> +.BR execve (2).
>   .RE
>   .IP
>   If all bits are 0,
> @@ -1251,6 +1257,17 @@ with the same value for
>   .I arg2
>   will fail with the error
>   .BR EPERM .
> +.\" commit 71368af9027f18fe5d1c6f372cfdff7e4bde8b48
> +.TP
> +.BR PR_SPEC_DISABLE_NOEXEC " (since Linux 5.1)"
> +Same as
> +.BR PR_SPEC_DISABLE ,
> +but but the state will be cleared on
> +.BR execve (2).
> +Currently only supported for
> +.I arg2
> +equal to
> +.B PR_SPEC_STORE_BYPASS.
>   .RE
>   .IP
>   Any unsupported value in
> @@ -1899,11 +1916,12 @@ was
>   .BR PR_SET_SPECULATION_CTRL
>   and
>   .IR arg3
> -is neither
> +is not
>   .BR PR_SPEC_ENABLE ,
>   .BR PR_SPEC_DISABLE ,
> +.BR PR_SPEC_FORCE_DISABLE ,
>   nor
> -.BR PR_SPEC_FORCE_DISABLE .
> +.BR PR_SPEC_DISABLE_NOEXEC .
>   .SH VERSIONS
>   The
>   .BR prctl ()

Acked-by: Waiman Long <longman@redhat.com>

