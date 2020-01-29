Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6878A14D0EF
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2020 20:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgA2TEy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jan 2020 14:04:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42475 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727515AbgA2TEy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jan 2020 14:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580324693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MbiGVjrJioZ203LFcL8jX4cOOERITrueTv3xiDYiAOg=;
        b=JcGo+H5vsO0zQrgYgYZgnKvXIU9rpjZ/9VncNyjySs1X6xZpGiYTA4UtTd+EGi90q0IOYh
        Vubn8LZZqfBjLpEL5hhmX01qstcRhFL8rz1LssYg7mbKQY5PKAqFyp3PauElze87+DKkja
        d9YFz47S1UliwP8AY1KfH/DnRY3jYGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-OxcRtN58MxuutJS4mbvVFA-1; Wed, 29 Jan 2020 14:04:48 -0500
X-MC-Unique: OxcRtN58MxuutJS4mbvVFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85103100550E;
        Wed, 29 Jan 2020 19:04:46 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB1FA5C28C;
        Wed, 29 Jan 2020 19:04:42 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Sandipan Das <sandipan@linux.ibm.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org,
        linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
References: <cover.1579507768.git.sandipan@linux.ibm.com>
        <3ceb2814-f8b0-ec6b-3c24-ec72297a99f5@intel.com>
Date:   Wed, 29 Jan 2020 20:04:40 +0100
In-Reply-To: <3ceb2814-f8b0-ec6b-3c24-ec72297a99f5@intel.com> (Dave Hansen's
        message of "Wed, 22 Jan 2020 10:45:27 -0800")
Message-ID: <8736by84on.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Dave Hansen:

> Still doesn't build for me:
>
>> # make
>> make --no-builtin-rules ARCH=x86_64 -C ../../../.. headers_install
>> make[1]: Entering directory '/home/dave/linux.git'
>>   INSTALL ./usr/include
>> make[1]: Leaving directory '/home/dave/linux.git'
>> make: *** No rule to make target '/home/dave/linux.git/tools/testing/selftests/vm/protection_keys_32', needed by 'all'.  Stop.

Do you have 32-bit libraries installed?

Thanks,
Florian

