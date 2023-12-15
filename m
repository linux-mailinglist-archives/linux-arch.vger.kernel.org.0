Return-Path: <linux-arch+bounces-1097-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18017815059
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 20:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230321C2378E
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 19:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8088341860;
	Fri, 15 Dec 2023 19:47:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E104184B;
	Fri, 15 Dec 2023 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 2539e6c80012c5e6; Fri, 15 Dec 2023 20:47:32 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C96C5668B59;
	Fri, 15 Dec 2023 20:47:31 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or functional) devices
Date: Fri, 15 Dec 2023 20:47:31 +0100
Message-ID: <5760569.DvuYhMxLoT@kreacher>
In-Reply-To: <20231215161539.00000940@Huawei.com>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk> <20231215161539.00000940@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedtvdefgeelvdefvdevveehvdetfeefhedvueeiudekieeltdetgfdviefhgfetteenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplfhonhgrthhhrghnrdevrghmvghrohhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgt
 hheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=22 Fuz1=22 Fuz2=22

On Friday, December 15, 2023 5:15:39 PM CET Jonathan Cameron wrote:
> On Fri, 15 Dec 2023 15:31:55 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>=20
> > On Thu, Dec 14, 2023 at 07:37:10PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Dec 14, 2023 at 7:16=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote: =20
> > > >
> > > > On Thu, Dec 14, 2023 at 7:10=E2=80=AFPM Russell King (Oracle)
> > > > <linux@armlinux.org.uk> wrote: =20
> > > > > I guess we need something like:
> > > > >
> > > > >         if (device->status.present)
> > > > >                 return device->device_type !=3D ACPI_BUS_TYPE_PRO=
CESSOR ||
> > > > >                        device->status.enabled;
> > > > >         else
> > > > >                 return device->status.functional;
> > > > >
> > > > > so we only check device->status.enabled for processor-type device=
s? =20
> > > >
> > > > Yes, something like this. =20
> > >=20
> > > However, that is not sufficient, because there are
> > > ACPI_BUS_TYPE_DEVICE devices representing processors.
> > >=20
> > > I'm not sure about a clean way to do it ATM. =20
> >=20
> > Ok, how about:
> >=20
> > static bool acpi_dev_is_processor(const struct acpi_device *device)
> > {
> > 	struct acpi_hardware_id *hwid;
> >=20
> > 	if (device->device_type =3D=3D ACPI_BUS_TYPE_PROCESSOR)
> > 		return true;
> >=20
> > 	if (device->device_type !=3D ACPI_BUS_TYPE_DEVICE)
> > 		return false;
> >=20
> > 	list_for_each_entry(hwid, &device->pnp.ids, list)
> > 		if (!strcmp(ACPI_PROCESSOR_OBJECT_HID, hwid->id) ||
> > 		    !strcmp(ACPI_PROCESSOR_DEVICE_HID, hwid->id))
> > 			return true;
> >=20
> > 	return false;
> > }
> >=20
> > and then:
> >=20
> > 	if (device->status.present)
> > 		return !acpi_dev_is_processor(device) || device->status.enabled;
> > 	else
> > 		return device->status.functional;
> >=20
> > ?
> >=20
> Changing it to CPU only for now makes sense to me and I think this code s=
nippet should do the
> job.  Nice and simple.

Well, except that it does checks that are done elsewhere slightly
differently, which from the maintenance POV is not nice.

Maybe something like the appended patch (untested).

=2D--
 drivers/acpi/acpi_processor.c |   11 +++++++++++
 drivers/acpi/internal.h       |    3 +++
 drivers/acpi/scan.c           |   24 +++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/acpi_processor.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/acpi/acpi_processor.c
+++ linux-pm/drivers/acpi/acpi_processor.c
@@ -644,6 +644,17 @@ static struct acpi_scan_handler processo
 	},
 };
=20
+bool acpi_device_is_processor(const struct acpi_device *adev)
+{
+	if (adev->device_type =3D=3D ACPI_BUS_TYPE_PROCESSOR)
+		return true;
+
+	if (adev->device_type !=3D ACPI_BUS_TYPE_DEVICE)
+		return false;
+
+	return acpi_scan_check_handler(adev, &processor_handler);
+}
+
 static int acpi_processor_container_attach(struct acpi_device *dev,
 					   const struct acpi_device_id *id)
 {
Index: linux-pm/drivers/acpi/internal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -62,6 +62,8 @@ void acpi_sysfs_add_hotplug_profile(stru
 int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handler,
 				       const char *hotplug_profile_name);
 void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, bool =
val);
+bool acpi_scan_check_handler(const struct acpi_device *adev,
+			     struct acpi_scan_handler *handler);
=20
 #ifdef CONFIG_DEBUG_FS
 extern struct dentry *acpi_debugfs_dir;
@@ -133,6 +135,7 @@ int acpi_bus_register_early_device(int t
 const struct acpi_device *acpi_companion_match(const struct device *dev);
 int __acpi_device_uevent_modalias(const struct acpi_device *adev,
 				  struct kobj_uevent_env *env);
+bool acpi_device_is_processor(const struct acpi_device *adev);
=20
 /* -----------------------------------------------------------------------=
=2D--
                                   Power Resource
Index: linux-pm/drivers/acpi/scan.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1938,6 +1938,19 @@ static bool acpi_scan_handler_matching(s
 	return false;
 }
=20
+bool acpi_scan_check_handler(const struct acpi_device *adev,
+			     struct acpi_scan_handler *handler)
+{
+	struct acpi_hardware_id *hwid;
+
+	list_for_each_entry(hwid, &adev->pnp.ids, list) {
+		if (acpi_scan_handler_matching(handler, hwid->id, NULL))
+			return true;
+	}
+
+	return false;
+}
+
 static struct acpi_scan_handler *acpi_scan_match_handler(const char *idstr,
 					const struct acpi_device_id **matchid)
 {
@@ -2410,7 +2423,16 @@ bool acpi_dev_ready_for_enumeration(cons
 	if (device->flags.honor_deps && device->dep_unmet)
 		return false;
=20
=2D	return acpi_device_is_present(device);
+	if (device->status.functional)
+		return true;
+
+	if (!device->status.present)
+		return false;
+
+	if (device->status.enabled)
+		return true; /* Fast path. */
+
+	return !acpi_device_is_processor(device);
 }
 EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
=20




