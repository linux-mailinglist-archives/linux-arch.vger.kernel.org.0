Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D884321C5B6
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jul 2020 20:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgGKSW5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Jul 2020 14:22:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47281 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726281AbgGKSW5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Jul 2020 14:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594491775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ltTy2GcHC036Egycy6GY0oL2cPL6zzaGde4AZbh1z7Q=;
        b=DkOIw48FNlR0A7+oI1hkc5NnHVHw/B1r0AteeI+P4OTbic7qxtah9lfEbNJOM9j/sqvqyN
        eWVypIk+KFqc0aCnNP6jra3norRGrvJwJORHDdxywBZpD1poGV9SJfhJPdUR8asqyI7m3h
        cavrk35TLcy3zgDfoQBbqQ0nO9r6gyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-5zlWZQn6MS6VvBPZPers8Q-1; Sat, 11 Jul 2020 14:22:53 -0400
X-MC-Unique: 5zlWZQn6MS6VvBPZPers8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB3A1107ACCA;
        Sat, 11 Jul 2020 18:22:51 +0000 (UTC)
Received: from llong.com (ovpn-112-135.rdu2.redhat.com [10.10.112.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FC965D9CC;
        Sat, 11 Jul 2020 18:22:47 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] locking/qspinlock: Allow lock to store lock holder cpu number
Date:   Sat, 11 Jul 2020 14:21:26 -0400
Message-Id: <20200711182128.29130-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset modifies the qspinlock code to allow it to store the lock
holder cpu number in the lock itself if feasible for easier debugging
and crash dump analysis. This lock holder cpu information may also be
useful to architectures like PowerPC that needs the lock holder cpu
number for better paravirtual spinlock performance.

A new config option QUEUED_SPINLOCKS_CPUINFO is added. If this config
option is set, lock holder cpu number will always be stored if the
number is small enough.  Without this option, lock holder cpu number
will only be stored in the slowpath of the native qspinlock.

Waiman Long (2):
  locking/qspinlock: Store lock holder cpu in lock if feasible
  locking/pvqspinlock: Optionally store lock holder cpu into lock

 arch/Kconfig                              | 12 ++++++
 arch/x86/include/asm/qspinlock_paravirt.h |  9 ++--
 include/asm-generic/qspinlock.h           | 13 ++++--
 include/asm-generic/qspinlock_types.h     |  5 +++
 kernel/locking/qspinlock.c                | 50 +++++++++++++++--------
 kernel/locking/qspinlock_paravirt.h       | 41 ++++++++++---------
 6 files changed, 87 insertions(+), 43 deletions(-)

-- 
2.18.1

