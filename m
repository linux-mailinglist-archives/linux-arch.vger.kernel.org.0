Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B353241F21A
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 18:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355059AbhJAQ2T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 12:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354755AbhJAQ2I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 12:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633105583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UwEKyPsnSKFhsqq8id3pFmmYALFQTXASAYKjNUFFU1A=;
        b=FS7/6pNDxrMC2CAaN+mNTMtBpgzwgF/zsS4FlUl1ozAGWe3iACwZ1haV7OvYV7ff2ASEpx
        YZ5o898kRgDFMcrU71Ui22cHANpisPvYGi+ffm5UW0w1RE+1S70eIHJYfeN6CNyfEMG/Tc
        oM/JwteXEFlddFdLqQ77IDxEHwkr9SQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-scy-XxOJOru9zldaLqk83A-1; Fri, 01 Oct 2021 12:26:20 -0400
X-MC-Unique: scy-XxOJOru9zldaLqk83A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E6AA1926DA0;
        Fri,  1 Oct 2021 16:26:18 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 847575DA61;
        Fri,  1 Oct 2021 16:26:13 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>,
        akiyks <akiyks@gmail.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
        <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
        <20210929174146.GF22689@gate.crashing.org>
        <2088260319.47978.1633104808220.JavaMail.zimbra@efficios.com>
Date:   Fri, 01 Oct 2021 18:26:11 +0200
In-Reply-To: <2088260319.47978.1633104808220.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Fri, 1 Oct 2021 12:13:28 -0400
        (EDT)")
Message-ID: <871r54ww2k.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Mathieu Desnoyers:

> One cheap way to achieve said R->W dependency (as well as R->RW on
> architectures which to not reorder R->R) is to ensure that the
> generated assembly contains a conditional branch.

Will any conditional branch do, or is it necessary that it depends in
some way on the data read?

Thanks,
Florian

