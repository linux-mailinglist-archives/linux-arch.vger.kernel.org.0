Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809603BF55E
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jul 2021 08:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhGHGIK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jul 2021 02:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229608AbhGHGIJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jul 2021 02:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625724327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wCYV9rADVa/Zk0J+SdK18xNcB21VXuhcx5+1Vv01yS4=;
        b=ZhJWEa6lQYjdBIYRomVqGRJPuv5ny4pgMuableob3n7s9psOCWrfFCh05reSAo0j2whddL
        VhGXBJBiyCxyMYM/v/V6OsvvlQeX4jbQeFpD4KkYqJBc2qGbCfI9I1ZsKezUKRGtgby/CP
        h9LnokGnj+OeoWD6VkLFEWaz47lLnRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-9-DnYDoaOMCTGRYBVNbyrA-1; Thu, 08 Jul 2021 02:05:25 -0400
X-MC-Unique: 9-DnYDoaOMCTGRYBVNbyrA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 509EB18D6A2A;
        Thu,  8 Jul 2021 06:05:20 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-5.ams2.redhat.com [10.36.115.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D14654450;
        Thu,  8 Jul 2021 06:05:17 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86 CPU features detection for applications (and AMX)
References: <87tulo39ms.fsf@oldenburg.str.redhat.com>
        <e376bcb9-cd79-7665-5859-ae808dd286f1@intel.com>
Date:   Thu, 08 Jul 2021 08:05:16 +0200
In-Reply-To: <e376bcb9-cd79-7665-5859-ae808dd286f1@intel.com> (Dave Hansen's
        message of "Wed, 23 Jun 2021 08:32:09 -0700")
Message-ID: <878s2hz6g3.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Dave Hansen:

> On 6/23/21 8:04 AM, Florian Weimer wrote:
>> https://www.gnu.org/software/libc/manual/html_node/X86.html
> ...
>> Previously kernel developers have expressed dismay that we didn't
>> coordinate the interface with them.  This is why I want raise this now.
>
> This looks basically like someone dumped a bunch of CPUID bit values and
> exposed them to applications without considering whether applications
> would ever need them.  For instance, why would an app ever care about:
>
> 	PKS =E2=80=93 Protection keys for supervisor-mode pages.
>
> And how could glibc ever give applications accurate information about
> whether PKS "is supported by the operating system"?  It just plain
> doesn't know, or at least only knows from a really weak ABI like
> /proc/cpuinfo.

glibc is expected to mask these bits for CPU_FEATURE_USABLE because they
have unknown semantics (to glibc).

They are still exposed via HAS_CPU_FEATURE.

I argued against HAS_CPU_FEATURE because the mere presence of this
interface will introduce application bugs because application really
must use CPU_FEATURE_USABLE instead.

I wanted to go with a curated set of bits, but we couldn't get consensus
around that.  Curiously, the present interface can expose changing CPU
state (if the kernel updates some fixed memory region accordingly), my
preferred interface would not have supported that.

> It also doesn't seem to tell applications what they want which is, "can
> I, the application, *use* this feature?"

CPU_FEATURE_USABLE is supposed to be that interface.

Thanks,
Florian

